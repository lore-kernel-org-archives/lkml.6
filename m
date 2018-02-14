Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032965AbeBNQu0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:50:26 -0500
Received: from mail-ot0-f178.google.com ([74.125.82.178]:37560 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032744AbeBNQuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:50:23 -0500
X-Google-Smtp-Source: AH8x225WcXrTupHp4vbjWPq53pDmZa3nfcCcJmuTVd6BgAczAy6HoNckXBHsnjuGfNfrBeJho3EBOA==
Date: Wed, 14 Feb 2018 08:50:16 -0800
In-Reply-To: <57ff1e429a7fc12300a3cca0c5e9a637beed0d3a.1518619058.git.msuchanek@suse.de>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de><97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de> <57ff1e429a7fc12300a3cca0c5e9a637beed0d3a.1518619058.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH 2/2] mmc: bcm2835: print some informational messages during reset
To: Michal Suchanek <msuchanek@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>, linux-mmc@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <FAD84DC4-510C-4AED-A310-A8F6D6FB4B5D@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1EGoUtG011961

On February 14, 2018 6:38:58 AM PST, Michal Suchanek <msuchanek@suse.de> wrote:
>The previous patch does reset during hardware error so make the reset
>progress more visible.

Based on your previous email it looks like this can happen quite frequently so we might be spamming the kernel log with such reset messages. Turning this into a debug print would not be great either, how about a custom sysfs attribute counting the number of times a reset was done?

We should ideally root cause this but I am sure we can.

-- 
Florian
