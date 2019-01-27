Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97B1C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9142F2133F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfA0V0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 16:26:36 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:47263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfA0V0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 16:26:36 -0500
Received: from oxbaltgw09.schlund.de ([172.19.246.15]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MScDh-1gdBnE2UCP-00Sv9L; Sun, 27 Jan 2019 22:26:33 +0100
Date:   Sun, 27 Jan 2019 22:26:33 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Ioan-Adrian Ratiu <adi@adirat.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Message-ID: <1658074547.62977.1548624393424@email.ionos.de>
In-Reply-To: <20190127202813.29493-1-adi@adirat.com>
References: <20190127202813.29493-1-adi@adirat.com>
Subject: Re: [RFC][PATCH] Revert "ARM: dts: bcm2837: Fix polarity of wifi
 reset GPIOs"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:oF5Lc4DXaajo42PaGmEcgpFoHUWWt54TvpdfWdqcKQZl8KzuQjE
 krIVMmnRGqZrwjZvaQNLzIoIdV1GKkzwnKrBfF7ajQPlwETlsXdVOVklpevS/6SXMrTAzTe
 U1bqcCgInX2JPOXVRE6dIKCuNSJbz66BpIFqflSQCLPC1XzjVRd9FdREtH/rpbjstHPzXVc
 3IrOdX8b+Tptt187YPKcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BcNq2ySY78I=:IMW2VofTsEFbwZ1mpy++Az
 VesDj0+jr/JnKi6UdqkGl9amY3OIRSUt5A0hx70tKVb5ZXucsNiDxrE/AhhLQD1gAvnvisOun
 ImkOHUwCLLYtE2gOBDAX2MRsGqLMrSwdnt11ygicxyZcEAW8bipoCsDuEOU7wNL72ga0VTCWD
 ZpEj+qKBGlA15b3lvuJ2vHrOsbBnXdprwScO0aGmin7SPx6ZOhMxQpEQCcmVPSn70osOX710y
 0aHt4D63ca9FaLjhq2PGAnRELdANxYHWtFmCLKdEIJ2881HjBVJSpoL7X5bdp4yqHkc028v8k
 7AHiO12FvqBZECZo9gdu2vrDikgWgPj35YTkzg9f+UIO0RzoLQrDHpaPglL9lczM2aK64RDoT
 Rq0qoDmtsExAxzvbIHVC+hjrtU1teNLXPZVbnnKH4lImkIfJUk7KtjndQgY+lEFUm7wYavSr4
 /3Kfhk7QfFctb0uULlPw1CuOvkxtgSxX6nHas/TejC1TcuEHJszdkb1GpDcEhdPlE0F4CCP+W
 I4/W/mdQyhqWrhiQPhKY7Y0MuSVkYnaNzsrer+GDvBBPrb78DtxW/7TL98rB6tVM2a+0tSWW3
 d239IRF7wynQOEmmWeeRLy9bP4t9y9Wa37DeTwa0l2OmASFnH8nnlvIA382R1oIV6RVGz6FxC
 ijuNzfCQ1V8CH4R/SeyiNbyLMxU+BOZVHZt0PNG2u4FOoRMiBZ3mnuuJHiVF9fUVNQTBdG06T
 R2JI3JfxHGebPq0fPFDD3H9lkHDj+fwPIWPJD2Kzcy44rVWMz6PHPCIIi4w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ioan-Adrian,

> Ioan-Adrian Ratiu <adi@adirat.com> hat am 27. Januar 2019 um 21:28 geschrieben:
> 
> 
> This reverts commit bea8a160c621d19f7f78b13e14e03f4b8e44cd4b.
> 
> Contrary to what the commit message says, on my rpi 3 b v1.2 changing
> the polarity causes the exact behaviour this commit intends to fix, as
> described at the referenced link below (wlan0 disapears).
> 
> With reset-gpios = ... GPIO_ACTIVE_HIGH, brcmfmac errors in dmesg:
> 
> [    7.977512] brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep state -110
> [    7.977623] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
> [    7.978007] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
> [    7.978377] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
> [    7.978724] brcmfmac: brcmf_sdio_dpc: failed backplane access over SDIO, halting operation
> [    7.978734] brcmfmac: brcmf_proto_bcdc_query_dcmd: brcmf_proto_bcdc_msg failed w/status -110
> [    7.978747] brcmfmac: brcmf_cfg80211_get_channel: chanspec failed (-110)
> [    7.982817] brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep state -110
> [    7.982880] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
> [    7.983255] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
> 
> The only solution I currently have is to revert and everything works
> as expected and as before changing the polarity.
> 
> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911443
> Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
> ---

reverting this commit will only workaround the real issue. It lies in the sdhci-iproc driver.

Could please try this instead patch [1]?

[1] - https://patchwork.kernel.org/patch/10741809/
