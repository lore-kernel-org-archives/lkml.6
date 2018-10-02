Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60D1C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B2120878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B2120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJBQSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:18:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeJBQSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:18:43 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9C8A32B672;
        Tue,  2 Oct 2018 09:36:22 +0000 (UTC)
Received: from ws.net.home (ovpn-117-176.ams2.redhat.com [10.36.117.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFEE5607CA;
        Tue,  2 Oct 2018 09:36:20 +0000 (UTC)
Date:   Tue, 2 Oct 2018 11:36:19 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     adilger@dilger.ca,
        Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        util-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        andy.shevchenko@gmail.com, aeb@debian.org, andreas.bombe@gmail.com
Subject: Re: Future of dosfstools project (FAT)
Message-ID: <20181002093619.nrmibtzouwraoyob@ws.net.home>
References: <20180929084038.an6pfhnsd6tblejl@pali>
 <404F3F76-402D-4E29-9957-429CB7D7ECFC@dilger.ca>
 <CAFLxGvxfegQFh0kvk81VLhLh0AkgvpT=hWMDCJz5FmgoTUNRqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvxfegQFh0kvk81VLhLh0AkgvpT=hWMDCJz5FmgoTUNRqA@mail.gmail.com>
User-Agent: NeoMutt/20180716-423-e60b71
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 02 Oct 2018 09:36:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 10:13:41PM +0200, Richard Weinberger wrote:
> On Mon, Oct 1, 2018 at 10:01 PM Andreas Dilger <adilger@dilger.ca> wrote:
> > If the current dosfstools maintainer is non-responsive, you could always
> > fork the project in GitHub, land the critical patches into your branch,
> >  and make a release on your own.  If the maintainer surfaces again, then
> > they can pull in your patches.  If not, then you are the new maintainer.
> 
> I also recommend talking to package maintainers of major distros.
> Maybe one of them forked the project already and did what you plan to do.
> 
> In any case, let's try to avoid a drama like util-linux-ng was.

Drama? :-) We had confirmed support from all mainstream distros before
the fork and rename. It was really not ad hoc solution. The project
has been renamed back to util-linux after confirmation from the
original maintainer.

Sometimes fork open source project is a good thing. The another
example is mutt -> mutt-kz -> neomutt ;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
