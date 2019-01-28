Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C824C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F722085B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfA1Sn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:43:58 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:36979 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfA1Sn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:43:57 -0500
Received: from oxbaltgw60.schlund.de ([172.19.246.147]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N3sNa-1hEgyw3Ga0-00zls7; Mon, 28 Jan 2019 19:43:54 +0100
Date:   Mon, 28 Jan 2019 19:43:54 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Ioan-Adrian Ratiu <adi@adirat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Message-ID: <1215525901.73446.1548701034611@email.ionos.de>
In-Reply-To: <87tvhs8wh7.fsf@ni.com>
References: <20190127202813.29493-1-adi@adirat.com>
 <1658074547.62977.1548624393424@email.ionos.de> <87tvhs8wh7.fsf@ni.com>
Subject: Re: [RFC][PATCH] Revert "ARM: dts: bcm2837: Fix polarity of wifi
 reset GPIOs"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:LUS+MFTdSu4HkRnzzeIv192AHhExZCIHWyaEMckypZ9n1vf/ixW
 kk/i/H1ttMcCK6pYc5cgNcmqZ/FMb5KrgUQof3qRTo2BTkqE+/fQcaQarl8JxfDmOOan/NG
 XG7pWvX+VeJYxIbXbp4C/CmGv6KAHgqIRCSur5WIADYB23tyBwbURBisGYlw9YRO8dta9Fs
 sd68Y2wa08nIW7+LLZLaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2KRN2xcLe/c=:95k/DRmN+Mtp234KsdpmsY
 7oA/kckwhh5irHw5doMNtrhTcrNsgoBUzAHrj4FvBh0KZMW3IwQE9psf7+wiRdid+CWGpNHME
 F5IXVizvg0uu4jhIshcXX8PLnqardLXrqVxl5xy+/rzrxzMcxbJvs/vh6OIhvkRFRaB47OL70
 q9Tq3r9c7DRvnfns8XHB0R0yk1kgpofnBjK4mv2p6o++/jlPcxeqWQdce7uFk2camm/xf8rAT
 cLpWKry+tbtmZ4oxHQ4tBhPoDZIywUYh2phJ/Z2heiYjFt34/5c5XEI0c4Zm7iHdE+BS9AqVH
 6pW3DgspxDl703id+OzCfS3ruHrB+QVGRJu8+GLrDjk1oz3Rt13iSpNpXzO7hdd00ALb0bf8a
 hgcyaLc/Qx5YnCQJixPameSXUWZiUy4nIpuoPuvRlkG7HN6XGZRTbKFscK1ptG7qakwGzVUe4
 8xS5J4eV1ebBybSzNljndUaxn+PQO/fLtzzmNymXhW6svPbCk3gbNssoVU5+FlTD4H1zmAN1U
 3zvhjiFmaEgqml4oz5Ef8MSSxALiIGZBY8q5jRsdOHVdW/YVFpkwKP0y1BRrtDcybruvUGF2l
 joowZPvcJdB4EKVKZKleDONClAC/hHcNKrsmZxvgDgYi6Hd/CmlGuKM15MSx2efOn0bIJTEiR
 XmAH5z0K7eanCSfWvF+8oaDLCTsMmi8mhx0TKmNUkRC0Tph4xZLKgcc4DZ/pd4O4YZKIYAFFx
 2OxPLbUTvAdwwqGpfcIon/oacVfHMtZgbDChskp/tPPzNn079jxMGeoLcKE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Ioan-Adrian Ratiu <adi@adirat.com> hat am 28. Januar 2019 um 19:31 geschrieben:
> 
> 
> Hi Stefan and thank you for looking into this,
> 
> On Sun, 27 Jan 2019, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > Hi Ioan-Adrian, 
> > 
> >> Ioan-Adrian Ratiu <adi@adirat.com> hat am 27. Januar 2019 um 
> >> 21:28 geschrieben:   This reverts commit 
> >> bea8a160c621d19f7f78b13e14e03f4b8e44cd4b.   Contrary to what 
> >> the commit message says, on my rpi 3 b v1.2 changing the 
> >> polarity causes the exact behaviour this commit intends to fix, 
> >> as described at the referenced link below (wlan0 disapears). 
> >> With reset-gpios = ... GPIO_ACTIVE_HIGH, brcmfmac errors in 
> >> dmesg:  [    7.977512] brcmfmac: brcmf_sdio_bus_sleep: error 
> >> while changing bus sleep state -110 [    7.977623] brcmfmac: 
> >> brcmf_sdio_txfail: sdio error, abort command and terminate 
> >> frame [    7.978007] brcmfmac: brcmf_sdio_txfail: sdio error, 
> >> abort command and terminate frame [    7.978377] brcmfmac: 
> >> brcmf_sdio_txfail: sdio error, abort command and terminate 
> >> frame [    7.978724] brcmfmac: brcmf_sdio_dpc: failed backplane 
> >> access over SDIO, halting operation [    7.978734] brcmfmac: 
> >> brcmf_proto_bcdc_query_dcmd: brcmf_proto_bcdc_msg failed 
> >> w/status -110 [    7.978747] brcmfmac: 
> >> brcmf_cfg80211_get_channel: chanspec failed (-110) [ 
> >> 7.982817] brcmfmac: brcmf_sdio_bus_sleep: error while changing 
> >> bus sleep state -110 [    7.982880] brcmfmac: 
> >> brcmf_sdio_txfail: sdio error, abort command and terminate 
> >> frame [    7.983255] brcmfmac: brcmf_sdio_txfail: sdio error, 
> >> abort command and terminate frame  The only solution I 
> >> currently have is to revert and everything works as expected 
> >> and as before changing the polarity.   Link: 
> >> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911443 
> >> Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com> --- 
> > 
> > reverting this commit will only workaround the real issue. It 
> > lies in the sdhci-iproc driver. 
> > 
> > Could please try this instead patch [1]? 
> 
> Yes, the patch fixes the bug and it's also in Linus' master branch 
> in v5.0-rc3 as commit 2bd44da ("mmc: sdhci-iproc: handle 
> mmc_of_parse() errors during prob").
> 
> There was just a minor conflict cherry-picking it to 4.19.y 
> (sdhci_get_property -> sdhci_get_of_property).
> 
> I would really like to have 2bd44da backported to the 4.19 stable 
> tree to have wifi working again. Please?
> 
> Tested-by: Ioan-Adrian Ratiu <adi@adirat.com> #4.19.18

i wasn't aware of this conflict until sunday. Yes, i will backport it.

Thanks
Stefan

> 
> >
> > [1] - https://patchwork.kernel.org/patch/10741809/
