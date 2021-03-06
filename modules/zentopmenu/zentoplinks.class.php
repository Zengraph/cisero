<?php
/**
 * Copyright (C) 2017-2019 thirty bees
 * Copyright (C) 2007-2016 PrestaShop SA
 *
 * thirty bees is an extension to the PrestaShop software by PrestaShop SA.
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/afl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@thirtybees.com so we can send you a copy immediately.
 *
 * @author    thirty bees <modules@thirtybees.com>
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2017-2019 thirty bees
 * @copyright 2007-2016 PrestaShop SA
 * @license   Academic Free License (AFL 3.0)
 * PrestaShop is an internationally registered trademark of PrestaShop SA.
 */

if ( ! defined('_TB_VERSION_')) {
    exit;
}

/**
 * Class ZenMenuTopLinks
 */
class ZenMenuTopLinks
{
    /**
     * @param int      $idLang
     * @param int|null $idLinkszenmenutop
     * @param int      $idShop
     *
     * @return array|false|null|PDOStatement
     * @throws PrestaShopDatabaseException
     * @throws PrestaShopException
     */
    public static function gets($idLang, $idLinkszenmenutop = null, $idShop)
    {
        $sql = 'SELECT l.id_linkszenmenutop, l.new_window, s.name, ll.link, ll.label
				FROM '._DB_PREFIX_.'linkszenmenutop l
				LEFT JOIN '._DB_PREFIX_.'linkszenmenutop_lang ll ON (l.id_linkszenmenutop = ll.id_linkszenmenutop AND ll.id_lang = '.(int) $idLang.' AND ll.id_shop='.(int) $idShop.')
				LEFT JOIN '._DB_PREFIX_.'shop s ON l.id_shop = s.id_shop
				WHERE 1 '.((!is_null($idLinkszenmenutop)) ? ' AND l.id_linkszenmenutop = "'.(int) $idLinkszenmenutop.'"' : '').'
				AND l.id_shop IN (0, '.(int) $idShop.')';

        return Db::getInstance()->executeS($sql);
    }

    /**
     * @param int $idLinkszenmenutop
     * @param int $idLang
     * @param int $idShop
     *
     * @return array|false|null|PDOStatement
     * @throws PrestaShopDatabaseException
     * @throws PrestaShopException
     */
    public static function get($idLinkszenmenutop, $idLang, $idShop)
    {
        return self::gets($idLang, $idLinkszenmenutop, $idShop);
    }

    /**
     * @param int $idLinkszenmenutop
     * @param int $idShop
     *
     * @return array
     * @throws PrestaShopDatabaseException
     * @throws PrestaShopException
     */
    public static function getLinkLang($idLinkszenmenutop, $idShop)
    {
        $ret = Db::getInstance()->executeS('
			SELECT l.id_linkszenmenutop, l.new_window, ll.link, ll.label, ll.id_lang
			FROM '._DB_PREFIX_.'linkszenmenutop l
			LEFT JOIN '._DB_PREFIX_.'linkszenmenutop_lang ll ON (l.id_linkszenmenutop = ll.id_linkszenmenutop AND ll.id_shop='.(int) $idShop.')
			WHERE 1
			'.((!is_null($idLinkszenmenutop)) ? ' AND l.id_linkszenmenutop = "'.(int) $idLinkszenmenutop.'"' : '').'
			AND l.id_shop IN (0, '.(int) $idShop.')
		');

        $link = [];
        $label = [];
        $newWindow = false;

        foreach ($ret as $line) {
            $link[$line['id_lang']] = Tools::safeOutput($line['link']);
            $label[$line['id_lang']] = Tools::safeOutput($line['label']);
            $newWindow = (bool) $line['new_window'];
        }

        return ['link' => $link, 'label' => $label, 'new_window' => $newWindow];
    }

    /**
     * @param Link $link
     * @param      $label
     * @param int  $newWindow
     * @param      $idShop
     *
     * @return bool
     * @throws PrestaShopDatabaseException
     * @throws PrestaShopException
     */
    public static function add($link, $label, $newWindow = 0, $idShop)
    {
        if (!is_array($label)) {
            return false;
        }
        if (!is_array($link)) {
            return false;
        }

        Db::getInstance()->insert(
            'linkszenmenutop',
            [
                'new_window' => (int) $newWindow,
                'id_shop'    => (int) $idShop,
            ]
        );
        $idLinkszenmenutop = Db::getInstance()->Insert_ID();

        $result = true;

        foreach ($label as $idLang => $label) {
            $result &= Db::getInstance()->insert(
                'linkszenmenutop_lang',
                [
                    'id_linkszenmenutop' => (int) $idLinkszenmenutop,
                    'id_lang'         => (int) $idLang,
                    'id_shop'         => (int) $idShop,
                    'label'           => pSQL($label),
                    'link'            => pSQL($link[$idLang]),
                ]
            );
        }

        return $result;
    }

    /**
     * @param     $link
     * @param     $labels
     * @param int $newWindow
     * @param     $idShop
     * @param     $idLink
     *
     * @return bool
     * @throws PrestaShopDatabaseException
     * @throws PrestaShopException
     */
    public static function update($link, $labels, $newWindow = 0, $idShop, $idLink)
    {
        if (!is_array($labels)) {
            return false;
        }
        if (!is_array($link)) {
            return false;
        }

        Db::getInstance()->update(
            'linkszenmenutop',
            [
                'new_window' => (int) $newWindow,
                'id_shop'    => (int) $idShop,
            ],
            'id_linkszenmenutop = '.(int) $idLink
        );

        foreach ($labels as $idLang => $label) {
            Db::getInstance()->update(
                'linkszenmenutop_lang',
                [
                    'id_shop' => (int) $idShop,
                    'label'   => pSQL($label),
                    'link'    => pSQL($link[$idLang]),
                ],
                'id_linkszenmenutop = '.(int) $idLink.' AND id_lang = '.(int) $idLang
            );
        }
    }

    /**
     * @param int $idLinkszenmenutop
     * @param int $idShop
     *
     * @return bool
     * @throws PrestaShopDatabaseException
     */
    public static function remove($idLinkszenmenutop, $idShop)
    {
        $result = true;
        $result &= Db::getInstance()->delete('linkszenmenutop', 'id_linkszenmenutop = '.(int) $idLinkszenmenutop.' AND id_shop = '.(int) $idShop);
        $result &= Db::getInstance()->delete('linkszenmenutop_lang', 'id_linkszenmenutop = '.(int) $idLinkszenmenutop);

        return $result;
    }
}
