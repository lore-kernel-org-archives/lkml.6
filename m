Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeAaHik convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:38:40 -0500
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:37881
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752534AbeAaHih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:38:37 -0500
X-ASG-Debug-ID: 1517384302-093b7e06e817a10001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "vinod.koul@intel.com" <vinod.koul@intel.com>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH 2/2] dmaengine: dmatest: add norandom option
Thread-Topic: Re: [PATCH 2/2] dmaengine: dmatest: add norandom option
X-ASG-Orig-Subj: Re: Re: [PATCH 2/2] dmaengine: dmatest: add norandom option
Thread-Index: AQHTmmZ9eTHWewgwr0u/+rXR+69sJA==
Date: Wed, 31 Jan 2018 07:38:30 +0000
Message-ID: <1517384301.6778.1.camel@hxt-semitech.com>
References: <1516617881-30044-1-git-send-email-shunyong.yang@hxt-semitech.com>
         <1516617881-30044-2-git-send-email-shunyong.yang@hxt-semitech.com>
         <20180131073424.GW18649@localhost>
In-Reply-To: <20180131073424.GW18649@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.3]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <3420562CE3C18D4B83836F6E2B652E9B@hxt-semitech.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: localhost[10.128.0.15]
X-Barracuda-Start-Time: 1517384302
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.3085 1.0000 -0.3123
X-Barracuda-Spam-Score: -0.31
X-Barracuda-Spam-Status: No, SCORE=-0.31 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.47443
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vinod

On Wed, 2018-01-31 at 13:04 +0530, Vinod Koul wrote:
> On Mon, Jan 22, 2018 at 06:44:41PM +0800, Yang Shunyong wrote:
> > 
> > Existing option noverify disables both random src/dst address
> > offset
> > setup and data verification. Sometimes, we need to control random
> > src/dst address setup and verification separately, such as
> > disabling
> > random to make sure that test covers addresses in all interleaving
> > banks in one run. This patch adds option norandom to disable random
> > offset setup. Option noverify has been changed to disable data
> > verification only.
> This doesn't apply for me due to dependency on previous patch. Please
> rebase
> and resend.
> 

Thanks. I have finished the rebase. I will send out v2 patch when I
finish test.

Thanks.
Shunyong.
