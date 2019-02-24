Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2EFC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F33620663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfBXTmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:42:19 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:42716 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfBXTmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:42:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id E8C78536E;
        Sun, 24 Feb 2019 20:42:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Oi5dUv3wAkKc; Sun, 24 Feb 2019 20:42:16 +0100 (CET)
Received: from function (unknown [198.134.98.50])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 46E9952FF;
        Sun, 24 Feb 2019 20:42:16 +0100 (CET)
Received: from samy by function with local (Exim 4.92-RC6)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1gxzf5-0003pm-Ml; Sun, 24 Feb 2019 20:42:07 +0100
Date:   Sun, 24 Feb 2019 20:42:07 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging : speakup: Fix format issues in Kconfig
Message-ID: <20190224194207.s7njsefej2iubvis@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Bharath Vedartham <linux.bhar@gmail.com>, w.d.hubbs@gmail.com,
        chris@the-brannons.com, kirk@reisers.ca, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20190224131142.GA9871@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190224131142.GA9871@bharath12345-Inspiron-5559>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharath Vedartham, le dim. 24 févr. 2019 18:41:42 +0530, a ecrit:
> Fix the checkpatch.pl warning to replace ---help--- with help in
> Kconfig.
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

> ---
> Changes since v1:
> 	- Allign help and removed redundant spaces.
> ---
>  drivers/staging/speakup/Kconfig | 42 ++++++++++++++++-------------------------
>  1 file changed, 16 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/speakup/Kconfig b/drivers/staging/speakup/Kconfig
> index efd6f45..4a78ab1 100644
> --- a/drivers/staging/speakup/Kconfig
> +++ b/drivers/staging/speakup/Kconfig
> @@ -3,7 +3,7 @@ menu "Speakup console speech"
>  config SPEAKUP
>  	depends on VT
>  	tristate "Speakup core"
> -	---help---
> +	help
>  		This is the Speakup screen reader.  Think of it as a
>  		video console for blind people.  If built in to the
>  		kernel, it can speak everything on the text console from
> @@ -43,7 +43,7 @@ config SPEAKUP
>  if SPEAKUP
>  config SPEAKUP_SYNTH_ACNTSA
>  	tristate "Accent SA synthesizer support"
> -	---help---
> +	help
>  		This is the Speakup driver for the Accent SA
>  		synthesizer.  You can say y to build it into the kernel,
>  		or m to build it as a module.  See the configuration
> @@ -52,7 +52,7 @@ config SPEAKUP_SYNTH_ACNTSA
>  config SPEAKUP_SYNTH_ACNTPC
>  	tristate "Accent PC synthesizer support"
>  	depends on ISA || COMPILE_TEST
> -	---help---
> +	help
>  		This is the Speakup driver for the accent pc
>  		synthesizer.  You can say y to build it into the kernel,
>  		or m to build it as a module.  See the configuration
> @@ -60,7 +60,7 @@ config SPEAKUP_SYNTH_ACNTPC
>  
>  config SPEAKUP_SYNTH_APOLLO
>  	tristate "Apollo II synthesizer support"
> -	---help---
> +	help
>  		This is the Speakup driver for the Apollo II
>  		synthesizer.  You can say y to build it into the kernel,
>  		or m to build it as a module.  See the configuration
> @@ -68,7 +68,7 @@ config SPEAKUP_SYNTH_APOLLO
>  
>  config SPEAKUP_SYNTH_AUDPTR
>  	tristate "Audapter synthesizer support"
> -	---help---
> +	help
>  		This is the Speakup driver for the Audapter synthesizer.
>  		 You can say y to build it into the kernel, or m to
>  		build it as a module.  See the configuration help on the
> @@ -76,7 +76,7 @@ config SPEAKUP_SYNTH_AUDPTR
>  
>  config SPEAKUP_SYNTH_BNS
>  	tristate "Braille 'n' Speak synthesizer support"
> -	---help---
> +	help
>  		This is the Speakup driver for the Braille 'n' Speak
>  		synthesizer.  You can say y to build it into the kernel,
>  		or m to build it as a module.  See the configuration
> @@ -84,8 +84,7 @@ config SPEAKUP_SYNTH_BNS
>  
>  config SPEAKUP_SYNTH_DECTLK
>  	tristate "DECtalk Express synthesizer support"
> -	---help---
> -
> +	help
>  		This is the Speakup driver for the DecTalk Express
>  		synthesizer.  You can say y to build it into the kernel,
>  		or m to build it as a module.  See the configuration
> @@ -93,8 +92,7 @@ config SPEAKUP_SYNTH_DECTLK
>  
>  config SPEAKUP_SYNTH_DECEXT
>  	tristate "DECtalk External (old) synthesizer support"
> -	---help---
> -
> +	help
>  		This is the Speakup driver for the DecTalk External
>  		(old) synthesizer.  You can say y to build it into the
>  		kernel, or m to build it as a module.  See the
> @@ -105,8 +103,7 @@ config SPEAKUP_SYNTH_DECPC
>  	depends on m
>  	depends on ISA || COMPILE_TEST
>  	tristate "DECtalk PC (big ISA card) synthesizer support"
> -	---help---
> -
> +	help
>  		This is the Speakup driver for the DecTalk PC (full
>  		length ISA) synthesizer.  You can say m to build it as
>  		a module.  See the configuration help on the Speakup
> @@ -127,8 +124,7 @@ config SPEAKUP_SYNTH_DECPC
>  config SPEAKUP_SYNTH_DTLK
>  	tristate "DoubleTalk PC synthesizer support"
>  	depends on ISA || COMPILE_TEST
> -	---help---
> -
> +	help
>  		This is the Speakup driver for the internal DoubleTalk
>  		PC synthesizer.  You can say y to build it into the
>  		kernel, or m to build it as a module.  See the
> @@ -138,8 +134,7 @@ config SPEAKUP_SYNTH_DTLK
>  config SPEAKUP_SYNTH_KEYPC
>  	tristate "Keynote Gold PC synthesizer support"
>  	depends on ISA || COMPILE_TEST
> -	---help---
> -
> +	help
>  		This is the Speakup driver for the Keynote Gold
>  		PC synthesizer.  You can say y to build it into the
>  		kernel, or m to build it as a module.  See the
> @@ -148,8 +143,7 @@ config SPEAKUP_SYNTH_KEYPC
>  
>  config SPEAKUP_SYNTH_LTLK
>  	tristate "DoubleTalk LT/LiteTalk synthesizer support"
> ----help---
> -
> +	help
>  		This is the Speakup driver for the LiteTalk/DoubleTalk
>  		LT synthesizer.  You can say y to build it into the
>  		kernel, or m to build it as a module.  See the
> @@ -158,8 +152,7 @@ config SPEAKUP_SYNTH_LTLK
>  
>  config SPEAKUP_SYNTH_SOFT
>  	tristate "Userspace software synthesizer support"
> -	---help---
> -
> +	help
>  		This is the software synthesizer device node.  It will
>  		register a device /dev/softsynth which midware programs
>  		and speech daemons may open and read to provide kernel
> @@ -169,8 +162,7 @@ config SPEAKUP_SYNTH_SOFT
>  
>  config SPEAKUP_SYNTH_SPKOUT
>  	tristate "Speak Out synthesizer support"
> -	---help---
> -
> +	help
>  		This is the Speakup driver for the Speakout synthesizer.
>  		 You can say y to build it into the kernel, or m to
>  		build it as a module.  See the configuration help on the
> @@ -178,8 +170,7 @@ config SPEAKUP_SYNTH_SPKOUT
>  
>  config SPEAKUP_SYNTH_TXPRT
>  	tristate "Transport synthesizer support"
> -	---help---
> -
> +	help
>  		This is the Speakup driver for the Transport
>  		synthesizer.  You can say y to build it into the kernel,
>  		or m to build it as a module.  See the configuration
> @@ -187,8 +178,7 @@ config SPEAKUP_SYNTH_TXPRT
>  
>  config SPEAKUP_SYNTH_DUMMY
>  	tristate "Dummy synthesizer driver (for testing)"
> -	---help---
> -
> +	help
>  		This is a dummy Speakup driver for plugging a mere serial
>  		terminal.  This is handy if you want to test speakup but
>  		don't have the hardware.  You can say y to build it into
> -- 
> 2.7.4
> 

-- 
Samuel
<y> update-menus: relocation error: update-menus: symbol _ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E, version GLIBCPP_3.2 not defined in file libstdc++.so.5 with link time reference
<y> quoi que ça peut bien vouloir dire ?
<D> N a eu la meme merde
<y> c ça que ça veut dire ? wow, c'est bien crypté :)
 -+- #ens-mim s'entraide -+-
