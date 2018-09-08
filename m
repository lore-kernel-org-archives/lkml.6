Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED1DC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C418206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C418206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeIHSLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 14:11:21 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35265 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeIHSLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 14:11:21 -0400
Received: from null ([172.19.249.150]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MT9v5-1gRSVw1Nbb-00Ue0f; Sat, 08
 Sep 2018 15:25:15 +0200
Date:   Sat, 8 Sep 2018 15:25:14 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Message-ID: <1366205674.39171.1536413114481@email.1und1.de>
In-Reply-To: <20180904155858.8001-4-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
 <20180904155858.8001-4-tiwai@suse.de>
Subject: Re: [PATCH 03/29] staging: bcm2835-audio: Clean up include files in
 bcm2835-ctl.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:iz5pEEOEZW2o9GXkylVNfl7bjl1vrLVVhLc13HYCDv07SrJmlI5
 HuH9tz+Ous7UgKVKZ6ijYyTozqnfQtSCoiaWB7z/mnCylVZ3q7HAsYN6ADfxbQXmgJnuJ6A
 +68eFia93ta8idy/yrNnlqhtuZgRSfToMGnB4xdljvv5SFO1DrmOvcDJfhUgcne5BZWbXZu
 s9Nqs3n/TIUpjQ949UIUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sOIGpJ2mEp4=:bIb+qBJeiOZISoL83m9xAs
 vtcOWrESPJOnb1AqrcDBILYpwHJHMXAQ9triQQ/Ezs0d2IJCT971vzRiIuHH58mD3WN7xJo/R
 dwtLJeITBwcAnw0rcN91Z2t3yMCR0pRFKVv5RWgtBaYhdjYncVSSVbkoYY9o8SINutYKdUayS
 iMpXNIOijb3yIefBuptKXt341Wbfld4f22keN1xj7NMQD/98dAZZ40xcuxHUmC0fFlObFxmrP
 088JGSF29dK2wLLCQ2YTlnpMJtgWMfdcgwxGQS/j6Gr/xwHvIoE41RhTTZjlffRSs72d9pOfQ
 ZruFBNyGOJ1+FKtrH2vQOZhHU8ughS+aekBRiv+Gf6bNM1kAIGRrxSDTCeS/Ilt+LuxNuahY/
 HYeTWc/V/1fm16W0Fif2VcOOS2havqSsPY2gx/cM/0zFQvaqFcExw0oB8IMjM5qmMcPe8CF/5
 92yNWchQinny/N0epXm9xDvIA2xaRaXR8qkDAwhhHl8CgPR18mBfqpJgah1xdr2gJdLiAIbMm
 l3al85FUNjn8aK+wn6IG6pWNAMZofeCTrSB2JC9uT45U1LE2Uqocf4ySMarPEJL1Wj6X/2JKX
 XganE/E6SiVuM8n6kwWDfrk0hTI+Um6LI1RqE71VWG7LhujWk928szJ+b2Rq/hKSpgiWuqJbV
 aemlFsTnXT6lFG5caLBXWKmFHMVhWg7KQkAkazAwfGa/EaNd7kwsfqd3O/qK62zD/AFePiWNl
 tK6TBY+uw9EvuKLb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Takashi Iwai <tiwai@suse.de> hat am 4. September 2018 um 17:58 geschrieben:
> 
> 
> Only a few of them are really needed.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  .../vc04_services/bcm2835-audio/bcm2835-ctl.c     | 15 ---------------

I think this patch and patch #23 could be merge in case a new series is required.

Stefan
