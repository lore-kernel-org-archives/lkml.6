Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F4FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53FD208B0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53FD208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390078AbeHPQ7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:59:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:36011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbeHPQ7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:59:04 -0400
Received: from localhost.localdomain ([79.203.83.237]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M0Ppl-1g8faH0bgD-00uab4; Thu, 16 Aug 2018 16:00:00 +0200
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 50C2480087; Thu, 16 Aug 2018 15:59:58 +0200 (CEST)
From:   Sven Joachim <svenjoac@gmx.de>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Linux 4.18.1
References: <20180816101429.GA10680@kroah.com>
        <20180816130540.eu4rs5rago6b5lzq@angband.pl>
Date:   Thu, 16 Aug 2018 15:59:58 +0200
In-Reply-To: <20180816130540.eu4rs5rago6b5lzq@angband.pl> (Adam Borowski's
        message of "Thu, 16 Aug 2018 15:05:40 +0200")
Message-ID: <878t56mmxt.fsf@turtle.gmx.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:65SSbyttq8uj5ieFRlpxr6PcxMrER8BbNekLlYd5d4tOP4hRCqi
 kuZfGiYhIGSM2tG477aXwuZOLybVdfOxEJFOphPWY8Wlwj3C91np1UtLU9b7faUWyvEjnEL
 RIBqV7f8fn8sVCI0v00md9nbDYIXXH1TYXayhwcqImQPhZrZzNFBLBmWDkC7mtX0s6gw1x0
 0ABKK33jBQ3yDmFKw7H3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f+kMO8iMQa8=:ebaKrLfYA/WJU+8vZxZ32S
 tVBM6Oo6Qs66liNe9mBpW1kljSjhh/247OiLtJDbZyWVCPewWJct3OQd01/31kF4ZYc2k/CD1
 cmZ8kEuZk7z/I8I+CmmaGT/z4fO3qcqu4pqabheahopqJfFPFmeFUpmj+pgC8XflHdB9lGhmC
 k8K1PZe2fercBTaYBt7VJq2ZOfi0YApLPu/m5JfuFYFxf1h0dxj2Hy72UV6LTvfdDPSl2Th7M
 An2Ay45V+Aiw05BIMs+59bHutDTDEYP4WFzUg6hgAWpAw1ZugBRnkN1GnyIOTEtkvr1opjkR7
 6heifoJJsHjppI/fI4vF+VmsoHmlqqiCLT4vMf1DrFcromkZzBiIu0Z4gY3/28969lDXpctaB
 Ae+MR5ZrskimBfeqZ8el+KhPqyScGOTGCwsF7Ok4X6qu5z0//f9yFQnWiy+Q55Zm2eGma7bUy
 KIM5JOQ6Tob2OKrBXPAZCwROFwuMkGoLJaqBx1KVpWVEMRqKVZduMzZxYrR46cdFexVeVByYG
 55XGWBP6SQLIx7g7giEnbpZKfb7XO/BoB969PUTo69faIKRjQJs6Bj8DDIDqwDuXSSLUPnAcx
 IYsSYqr6FCY+Yc35uW19WytjGisLFU8TiZBiBNapEWxNN1Or5UZREiOQHqe03N1hN9NUW8+Q9
 ff0SknFRWQ7Ce8I3p5Zt7GSiwCVg3hpmMA6LUn+ViF5p5l82WR+kVI1bVXh7/USSG/TdVyt+l
 T95oyJyLqhSviNNw9wa5p3KU+fTrLNQO8WJzLLaeFjvHJj7+TxuJQHSPMwhcWy21O/FPDJPLx
 i7x1BjZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-16 15:05 +0200, Adam Borowski wrote:

> On Thu, Aug 16, 2018 at 12:14:29PM +0200, Greg KH wrote:
>> I'm announcing the release of the 4.18.1 kernel.
>
> I'm afraid that I get a build failure; v4.18 is ok, v4.18.1 fails with:
>
> ld: arch/x86/kvm/x86.o: in function `kvm_get_arch_capabilities':
> (.text+0x43b2): undefined reference to `l1tf_vmx_mitigation'

Same here and also in 4.17.15, but not in Linus' tree.

> .config attached.

Probably relevant:

> CONFIG_KVM=y
> # CONFIG_KVM_INTEL is not set
> CONFIG_KVM_AMD=y

I have CONFIG_KVM{,AMD}=m and CONFIG_KVM_INTEL is not set either.

Cheers,
       Sven
