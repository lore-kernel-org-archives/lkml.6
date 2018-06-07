Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qDqSBU8IGVsEUQAAmS7hNA
	; Thu, 07 Jun 2018 10:26:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 06BBE608B8; Thu,  7 Jun 2018 10:26:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8D20560452;
	Thu,  7 Jun 2018 10:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D20560452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932660AbeFGK0U (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:26:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55603 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932118AbeFGK0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:26:17 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 08CD18059A; Thu,  7 Jun 2018 12:26:15 +0200 (CEST)
Date: Thu, 7 Jun 2018 12:26:13 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Gao Xiang <gaoxiang25@huawei.com>
Cc: Richard Weinberger <richard@sigma-star.at>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        miaoxie@huawei.com, yuchao0@huawei.com, sunqiuyang@huawei.com,
        fangwei1@huawei.com, liguifu2@huawei.com, weidu.du@huawei.com,
        chen.chun.yen@huawei.com, brooke.wangzhigang@hisilicon.com,
        dongjinguang@huawei.com
Subject: Re: [NOMERGE] [RFC PATCH 00/12] erofs: introduce erofs file system
Message-ID: <20180607102613.GB4372@localhost>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <CAFLxGvw5PXBLKuaaK5xipiwTOXohtdeenD0XQHgX6+r4rS=GqQ@mail.gmail.com>
 <aae078b7-c364-106a-dd56-91abc945d7bb@huawei.com>
 <1670077.cnVahIradn@blindfold>
 <863d726d-e919-9ee1-56e4-994c8ab09f4b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <863d726d-e919-9ee1-56e4-994c8ab09f4b@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> We also think of other candidate full names, such as
> >> Enhanced / Extented Read-only File System, all the names short for "erofs" are okay.
> > 
> > TBH, I read "erofs" as "error fs". ;-)
> eh..."erofs" indeed comes from the EROFS error code, that is a playful behaviour...
> I think the error code of EROFS is not so bad... :'(

For the record, I understood the wordplay before I seen the
explanation, and I like it :-).
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
