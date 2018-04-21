Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeDUSkq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 14:40:46 -0400
Received: from sonic309-39.consmr.mail.ir2.yahoo.com ([77.238.179.97]:34088
        "EHLO sonic309-39.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753077AbeDUSko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 14:40:44 -0400
X-YMail-OSG: ISeiGXEVM1mayBo9eo_LcSezprokLIz86T24n.isZMXve9nF03LF3jdErSvS2Xr
 JFXwN_zWWL.pNa_lEM_oHiow902ZfZHxh_a3KzYiLPS1Q1B2kffOP7ygs739bBqn.LrbWYYPGbsZ
 FD3s2TeYMixy1cxxUPtI6wFfZOF1mRP_SO6q4rUQWG_IweaSmuE3pOLYd7th1SSpwzfgekqMW4CM
 lpGXi__slKZx_9pycFRBgjzIxOAaclhcAkULYv8IBsKTpUoz.5Qvj2d3FXq6JEW67t1U9yAViXj3
 OBAws2dc0Q4SjFcHwv8b6MPZPT0hxw3_UrMkyZI.OBctY86IevoH5KpeJD.JlRLImtw__5T2_j20
 9fvO6IGC23GoefbmBnBnct6N4bppLi8JyhL2MMB21xaSnXcl7dLuVB_0B_eA9tTGlCX5IpFrktfP
 dvDP1BP6GzC76gWcJeYlAjBnlgMHJeoGpc8iktBJ_m_TAOhzeVgoB_YeYVjt5.E1rMKV1poGjQIJ
 lOYEzdTH0W2NesNBUckPdZEOhxxY1ET7_.KE56TKrJmsTh_XP6Dvv2JoD1UwzLJ7ykBQih_LLl22
 Ypc11Kxvbnw--
Subject: Re: [PATCH] platform/x86: acer-wmi: add another KEY_POWER keycode
To: Antonio Rosario Intilisano <antonio.intilisano@gmail.com>,
        dvhart@infradead.org
Cc: andy@infradead.org, vger@kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20180420212641.30338-1-antonio.intilisano@gmail.com>
From: Gianfranco Costamagna <locutusofborg@debian.org>
Openpgp: preference=signencrypt
Autocrypt: addr=locutusofborg@debian.org; prefer-encrypt=mutual; keydata=
 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
 Q5L9/98u3iU=
Message-ID: <a62dded5-0fa9-1a6e-dd71-3e03cc311f1f@debian.org>
Date: Sat, 21 Apr 2018 20:40:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420212641.30338-1-antonio.intilisano@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hello,

On 20/04/2018 23:26, Antonio Rosario Intilisano wrote:
>     Now that we have informed the firmware that the Power Button driver is
>     active, laptops such as the Acer Swift 3 will generate
>     a WMI key event with code 0x87 when the power button key is
>     pressed. 
>     
>     Add this keycode to the table so that it is converted to an appropriate
>     input event.
> 

I don't know why Acer folks didn't merge this into the kernel yet, but this patch
seems to fix a real issue, so I'm thinking about uploading it in Ubuntu right now.

Antonio, I forgot to tell you before, can you please open an Ubuntu bug so we can track the change?
(ubuntu-bug linux should do the trick)

Gianfranco

> Signed-off-by: Antonio Rosario Intilisano <antonio.intilisano@gmail.com>
> Acked-by: Gianfranco Costamagna <locutusofborg@debian.org>
> Cc: Chris Chiu <chiu@endlessm.com>
> Cc: Daniel Drake <drake@endlessm.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> ---
>  drivers/platform/x86/acer-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 1be71f956d5c..8952173dd380 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -129,6 +129,7 @@ static const struct key_entry acer_wmi_keymap[] __initconst = { 	{KE_IGNORE, 0x83, {KEY_TOUCHPAD_TOGGLE} },
>  	{KE_KEY, 0x85, {KEY_TOUCHPAD_TOGGLE} },
>  	{KE_KEY, 0x86, {KEY_WLAN} },
> +	{KE_KEY, 0x87, {KEY_POWER} },
>  	{KE_END, 0}
>  };
>  
> 

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJa24WoAAoJEPNPCXROn13Zih8P/R8TOet5JdpAqdu9o/YUjP6b
iBhygp3rPJgXjzEnGtHvrukzu1MviL82iE1evelbUrmNuT6/aw++PabZ89rTzGwE
TVGJcjG6gl05UjCLjNE9G0xscb0aj3+bLf7ogZ+boUrjOU0xpZrutlGwh7XhSd26
sp+3PnkxccnLI6rSLXOVZqB3JaDa5+QJRlb/NudboawHp5dH4QiYdcHv/lOiKIh4
3ur+HaMfDannMQDzwN5FMWrP5jepjsEPq7R5D0QkUc/ivY6Nod7722aKU8Vilxol
tPPcUHWm/fGjYM4AGp8z1zH31FUCWyJjg404Ncb5AOcnoV2iVwN6KZkCM/WSjtwu
R+G2tYy2cX6DPqK5jUw5LyriA595DkpsHUa3p13nm0NhgpkM6EQT787AlTn6QJqQ
/MAJBfwRYuqc7+aG2CWg4OpKjFn6v8wfh2wEa6sMcbsemaqL9ct1ZS6NzNHAbuNS
BJRyuEnrmrQ9DEkPoLUo7pK1zeCNT5M0PkQy4BIPxD7FLh7IFVr24kOrUw6zq6sL
MomvE37pfqAb3FBWsVch32ERrBhA+8nBjl17j54F9N2DUfl1ZL6ZvIL77ah1ZpY1
7oBMDKpYwJbL36uDV7vXOO3FlO1vUjUMckmEer2lDskbZyFazYTRF4aUTS6uvAWJ
R9QJxPQbHC339wL5tEDm
=qQE6
-----END PGP SIGNATURE-----
