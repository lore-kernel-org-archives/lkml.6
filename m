Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208D9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7254213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfAJVeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:34:23 -0500
Received: from www17.your-server.de ([213.133.104.17]:57944 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbfAJVeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:34:23 -0500
X-Greylist: delayed 1787 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jan 2019 16:34:23 EST
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1ghhVD-0004o7-PZ
        for linux-kernel@vger.kernel.org; Thu, 10 Jan 2019 22:04:35 +0100
Received: from [2a02:908:4c28:3f60:fff6:43c5:695c:41d6] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1ghhVD-000Ugr-Ka
        for linux-kernel@vger.kernel.org; Thu, 10 Jan 2019 22:04:35 +0100
From:   Thomas Meyer <thomas@m3y3r.de>
To:     linux-kernel@vger.kernel.org
Subject: uio drivers?
Date:   Thu, 10 Jan 2019 22:04:35 +0100
Message-ID: <87r2dkb4ws.fsf@m3y3r.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.2/25286/Thu Jan 10 19:31:28 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wanted to have a look at some existing userspace i/o drivers, but
wasn't able to find any. do such drivers exist?
Can anybody point me to some uio drivers with open source code?

with kind regards
thomas
