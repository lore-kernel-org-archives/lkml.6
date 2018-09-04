Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B36C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A982075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A982075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeIEAeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:34:05 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIEAeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:34:05 -0400
Received: from null ([172.19.246.151]) by mrelayeu.kundenserver.de (mreue103
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MTveb-1gNqrf0XK5-00Qi2k; Tue, 04
 Sep 2018 22:07:18 +0200
Date:   Tue, 4 Sep 2018 22:07:15 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Eric Anholt <eric@anholt.net>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <1892655944.623.1536091635278@email.1und1.de>
In-Reply-To: <87wos1gny5.fsf@anholt.net>
References: <20180828074200.440fb5ca@canb.auug.org.au>
 <87wos1gny5.fsf@anholt.net>
Subject: Re: linux-next: error when fetching the bcm2835 tree
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev36
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:Esx4FToVOE+CeabpgbC12nIN0RLMkXy49njvIAsqo0UjoH+Lwd0
 g2BrDtAE0KPukbyQ6+pK5vz1I7gyZkXD0Js7jf6znTy4vl1fX4+Xrsbr/MNfaqhFO65AZxs
 0nL3doHhMqza/iJwRoDPAg3ZQ3mS6g2MXieOAX+QliKsV5r/zeyhh0uNG/2aAFU8kXIZZQC
 c7ZHFUqi5YOHBAS3OUCBw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aDXK106Cszc=:rM7CVCBn7//8PwmZh0zCyf
 fPbcVa2iaLRvwEzb6JGIUaWrxo22cAHqLOvrA0lOqqkl8PrtDyBIzK3f6IAWkDXQdZcTlozf2
 ARdLeYB7XmDOSP0ZphU2GrYaRfyE/4utl7ZZVXn9+QN+iZO3TZusYzSgUgc3XR0MS7e+ON1iY
 Jpfv8AUN+LS6TN2qu7mbqzfBG7RJeQ7locgtK85YzkhqZCk0yPrmoDvrUEpoD1hPxHd7pMBxu
 ynxNIzbTiebe3cBz2lobiLVtkxED7VXgp5Dh0vUJS/vUD19rWbpy3C3wrJOxb2RLgnxpWPVHz
 lv+rVXndLcDsfVzYsBm/Z0Up+rDESpZQexuMZNgIbtJuh7dFm0pfi/TyU4Nk0KwKFQu7ZH2fV
 tsBzEFM56yRDM4SNFUhmBG2EuAasnww7qslPtLbbB9grpobK6f90z2Z8UoipWOpKQos1CuxCd
 ukOl9wnOfMuEPuvRjTnvwiE0LypwXNiF8LBI3IstNz1C+Lovgq0TbRRXTPONJvtzK/kgVlAFe
 MMAZ/+plu1m3pgHFebUK2GaXVTTWwwEnmnkzoz11bThtuhaULvisXN7rQ/Wvd79PKLp1olXX/
 fW7cmV6t01/oSdP+WuIZe1yhzRjQoaCj7eWq5ISjQxtYi9wHNG+32DZ1oPbOldAhTaTGBEv0n
 jrPPy4hYpBZKH/R53jPINPTqLOUpKIxoV0PKOW9i6lMeUSVi9JJCnMnx8vW1b6YbdOEGg7owz
 JBw/a5TBUnAD68l2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Eric Anholt <eric@anholt.net> hat am 4. September 2018 um 19:41 geschrieben:
> 
> 
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
> > [ Unknown signature status ]
> > Hi Eric,
> >
> > Fetching the bcm2835 tree (git://github.com/anholt/linux.git#for-next)
> > produces this error:
> >
> > fatal: Couldn't find remote ref refs/heads/for-next
> 
> I'd passed responsibility for the git tree off to Stefan while I'm
> mostly-unavailable due to new baby.  Maybe Stefan had deleted the branch
> for a bit?

sorry for that. I deleted the branch and i manually setup the new one later.

I hope, everything is fine now?

> 
> Stefan -- the for-next branch is what linux-next pulls in, and I was
> regenerating it whenever I pushed -next branches.  You can find one set
> of scripts for helping generate a for-next branch at
> git://git.kernel.org/pub/scm/linux/kernel/git/tegra/maint-scripts.git

Cool

Stefan
