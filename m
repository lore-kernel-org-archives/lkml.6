Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeDKRVa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 13:21:30 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:36351 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752735AbeDKRV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 13:21:28 -0400
Date: Wed, 11 Apr 2018 18:04:33 +0100
From: "Maciej W. Rozycki" <macro@mips.com>
To: James Hogan <jhogan@kernel.org>
CC: Sinan Kaya <okaya@codeaurora.org>, <linux-mips@linux-mips.org>,
        <arnd@arndb.de>, <timur@codeaurora.org>, <sulrich@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
In-Reply-To: <20180406212601.GA1730@saruman>
Message-ID: <alpine.DEB.2.00.1804111756420.1545@tp.orcam.me.uk>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org> <1522760109-16497-2-git-send-email-okaya@codeaurora.org> <41e184ae-689e-93c9-7b15-0c68bd624130@codeaurora.org> <b748fdcb-e09f-9fe3-dc74-30b6a7d40cbe@codeaurora.org>
 <20180406212601.GA1730@saruman>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.219]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1523467282-298554-16273-9406-1
X-BESS-VER: 2018.4-r1804052328
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191885
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> > Any news on the MIPS front? Is this something that Arnd can merge? or does it have
> > to go through the MIPS tree.
> 
> It needs some MIPS input really. I'll try and take a look soon. Thanks
> for the nudge.
> 
> > It feels like the MIPS is dead since nobody replied to me in the last few weeks on
> > a very important topic.
> 
> Not dead, just both maintainers heavily distracted by real life right
> now (which sadly, for me at least, trumps this very important topic) and
> doing the best they can given the circumstances.

 Can I help move this change forward anyhow?

  Maciej
