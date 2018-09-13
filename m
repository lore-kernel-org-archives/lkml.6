Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBA4C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 01:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601AA213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 01:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601AA213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeIMGsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 02:48:35 -0400
Received: from smtp.infotech.no ([82.134.31.41]:47014 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbeIMGsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 02:48:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 390F92041D7;
        Thu, 13 Sep 2018 03:41:23 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Aro7qH5JpLjw; Thu, 13 Sep 2018 03:41:19 +0200 (CEST)
Received: from [192.168.48.23] (host-45-58-207-169.dyn.295.ca [45.58.207.169])
        by smtp.infotech.no (Postfix) with ESMTPA id D099C20417A;
        Thu, 13 Sep 2018 03:41:18 +0200 (CEST)
Reply-To: dgilbert@interlog.com
To:     SCSI development list <linux-scsi@vger.kernel.org>
Cc:     Martin Pitt <mpitt@debian.org>,
        David Sommerseth <davids@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Ritesh Raj Sarraf <rrs@researchut.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
Subject: [Announce] sg3_utils-1.44 available
Message-ID: <06575258-57b6-95f0-061b-0219e6481338@interlog.com>
Date:   Wed, 12 Sep 2018 21:41:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lack of synchronization between my subversion repository and the official
git mirror led to this release tag:
    https://github.com/hreinecke/sg3_utils/releases/tag/v1.43
dated 20160218 (my svn revision 665). That led some distributions to
believe that sg3_utils-1.43 was released over 2.5 years ago, rather
than yesterday.

Clean up the discrepancy by rolling forward to sg3_utils-1.44 with
minimal changes from the release yesterday (basically just changing
1.43 to 1.44 in several places). All tarballs and packages have been
regenerated.

Otherwise the release announcement for 1.43 from yesterday still applies:
   https://www.spinics.net/lists/linux-scsi/msg123230.html


Distributions: please use sg3_utils-1.44 to minimize further confusion.
Future changes will go into 1.45 .

Doug Gilbert
