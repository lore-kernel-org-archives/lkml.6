Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A96CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2544724C80
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2544724C80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=juzza.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933112AbeGCIMA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:12:00 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42025 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754309AbeGCIL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:11:57 -0400
Received: from null ([172.19.249.27]) by mrelayeu.kundenserver.de (mreue003
 [212.227.15.163]) with ESMTPSA (Nemesis) id 0McAjL-1fsCOJ3Zqx-00JXny; Tue, 03
 Jul 2018 10:11:00 +0200
Date:   Tue, 3 Jul 2018 09:10:55 +0100 (BST)
From:   Justin Skists <justin.skists@juzza.co.uk>
To:     w.d.hubbs@gmail.com, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, Tamir Suliman <tsuliman@linuxvaults.com>
Cc:     devel@driverdev.osuosl.org, chris@the-brannons.com,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <1527895743.93688.1530605455516@email.1and1.co.uk>
In-Reply-To: <1530603080-1353-1-git-send-email-tsuliman@linuxvaults.com>
References: <1530603080-1353-1-git-send-email-tsuliman@linuxvaults.com>
Subject: Re: [PATCH 3/3] drivers/speakup: Fix style and coding warnings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev34
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:juLbk6DJAn2MNbuhNCKt3iOFNXzghpzXrRe/ItgLcNz41mixYbZ
 Y9DdqzgMk7eaLXerZ5I6ZegraHUxMB1tobKO7K/BAzKrOY2HfhbbAReH+iHyzxNM2tD0AOm
 sHacH3nDePNCKgu8sdSKMT2wUDWJBuxpgxaEnsFUquSZE/MJAz+n6af+xCO/01outDnFKwJ
 B/nejLBXUQ7eAIhGbvkwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BxvH5yO6tK0=:zu7WVEaswtKyEw6n8Hc6yr
 jaSg+YBorH+NG1Lj2gk8y3vY8YX28ODpIoJmHj++CSEgyg1/JcxulAai4Y3tcpH28sfnDKoNi
 AHhcWoRP/X5xXvuf5Lj9J6kn+iGUPZsMSZSKsNRd37/MO/nO5ELAbDxc/2AV67oEAS9puUb5U
 ohoihRxoHceIZbbH/rS1VM91bw+7MW1j91vLGO7RFAIw//tPP/PVEdUdJayhbVtd9rLFHK0Xu
 BAFsuyl+mcynyh4Ou86XxK5LFsEP7asrdoOVO/oTNXy2D1OgsP2gxCiUJfA/5l8vYGcJIcydi
 QU19WSMzTzP5HWPmTKUCnwlWNC/qASwiE0O+4mJQN8UA8zmZvz0mD/NOSkQntjPuiz07vRYW2
 8wRaN+RBF2tYFS9drQbrNHLLFskQd2f6y/WX8aohhehKkYNyGmOFlblhY3V4f8FwTYH9Atzug
 JVVVvlGJ4rBbL+M26+2/jDhk6CGwg8OHc5H9TiBJwWs3PRL1STHtkjrkR8AFZT9zNJWw1WBpO
 vic+zieRwXSpdxqVyK1Y9b8POLozBYsoc4W8oT0QcmfSR3PLlVSSG3zSSxS6K/3xAc47/VBTb
 ZGdSUsPfYbv3t1gk+6Z8ai1i1GxwDTLOTPtL7mBWmIn9hO3Z3raFzKjhbKKym8HHm6qWzv2s9
 cPQDWVgaET8DoGxpiBf6MFTW4cLJcFFNRl2oWrfSeVwW1xLoAXdaDkXna5h4Cn6DgP73qoYoU
 2ey9zTeqMb2fpFYl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 03 July 2018 at 08:31 Tamir Suliman <tsuliman@linuxvaults.com> wrote:

> +++ b/drivers/staging/speakup/keyhelp.c
> @@ -167,7 +167,7 @@ int spk_handle_help(struct vc_data *vc, u_char type, u_char ch, u_short key)
>  		synth_printf("%s\n", spk_msg_get(MSG_HELP_INFO));
>  		build_key_data(); /* rebuild each time in case new mapping */
>  		return 1;
> -	} else {
> +	} else if {

Interesting construct...


> @@ -787,7 +787,7 @@ static ssize_t message_store_helper(const char *buf, size_t count,
>  			continue;
>  		}
>  
> -		index = simple_strtoul(cp, &temp, 10);
> +		index = simple_ktrtoul(cp, &temp, 10);

Did you compile this?


Justin.
