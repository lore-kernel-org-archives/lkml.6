Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A112C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671462070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lSXTqP2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfAID4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:56:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61926 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbfAIDzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:55:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A763B11930C;
        Tue,  8 Jan 2019 22:55:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=sBOZAASX4pT+aW4/bJh8+i++wuo=; b=lSXTqP2W/E+EsJtUcSeI
        dL1P5z0HetcK3VDatD5O3uB8WBgv0N0KesZkFF0wnEGqppteKntIo4sYetq8ZzhP
        OOUbSuEUTG0lku0pd1DzC5u4E5pR4kuqYisUhzk+oogJUnrkoON0CQW73rV8MX3F
        gEXUMycK7UgFL+FV42HMbqM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93872119302;
        Tue,  8 Jan 2019 22:55:46 -0500 (EST)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B7AC1192F9;
        Tue,  8 Jan 2019 22:55:46 -0500 (EST)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTP id F36D12DA019C;
        Tue,  8 Jan 2019 22:55:44 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Mielke <Dave@mielke.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] assorted console/vt/vcs fixes
Date:   Tue,  8 Jan 2019 22:54:58 -0500
Message-Id: <20190109035504.8413-1-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Pobox-Relay-ID: 7184D2A8-13C2-11E9-AB73-70EFDD2159A7-78420484!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Here's a few patches fixing various issues. The first 2 are most
certainly stable material. I don't know if the other issues are serious e=
nough to be stable worthy though.
Please feel free to tag them as such if so.


Nicolas

