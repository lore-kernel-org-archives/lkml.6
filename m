Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98688C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8E42082F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbfAaM01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:26:27 -0500
Received: from shell.v3.sk ([90.176.6.54]:37648 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbfAaM01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:26:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DB64ACD109;
        Thu, 31 Jan 2019 13:26:23 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id P03q6bcpyMLu; Thu, 31 Jan 2019 13:26:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 992FFCD10A;
        Thu, 31 Jan 2019 13:26:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Sr6c69K4ldKn; Thu, 31 Jan 2019 13:26:20 +0100 (CET)
Received: from nedofet (unknown [82.202.112.231])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 655BCCD109;
        Thu, 31 Jan 2019 13:26:19 +0100 (CET)
Message-ID: <0adff00d4c4797fe1f9d593a7ba7c772ac3312c4.camel@v3.sk>
Subject: Re: [PATCH v5 2/7] x86, olpc: Use a correct version when making up
 a battery node
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Date:   Thu, 31 Jan 2019 13:26:16 +0100
In-Reply-To: <20190123205627.nbddtfuy6qdo2bgb@earth.universe>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
         <20190110174005.1202564-3-lkundrak@v3.sk>
         <20190123205627.nbddtfuy6qdo2bgb@earth.universe>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2019-01-23 at 21:56 +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jan 10, 2019 at 06:40:00PM +0100, Lubomir Rintel wrote:
> > The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> > ambient temperature. Add a different compatible string to the 1.5
> > battery.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > ---
> 
> I either need an Acked-by from the x86 platform maintainers, that I
> can queue this through power-supply or a pull request for an immutable
> branch (probably the better idea).

I'm happy to prepare a branch that could be pulled from. In fact,
here's a branch with fixes for issues pointed out by the review that
could be pulled from:

  git pull https://github.com/hackerspace/olpc-xo175-linux lr/olpc-xo175-battery-for-v5.1

What do really not understand is how does this help. This is probably
just my unfamiliarity with the process; but perhaps you could help me
get less unfamiliar. Would it somehow help with a potential (though
unlikely) conflict resolution? Would an Ack from x86 crowd serve as an
altenative way off making sure things in their tree won't conflict with
this one?

> -- Sebastian

Thank you
Lubo

