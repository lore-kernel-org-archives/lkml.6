Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TVD_SPACE_RATIO autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983E0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695AA20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695AA20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=probesys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439789AbeKWX5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:57:23 -0500
Received: from probesys-mail.probesys.net ([37.26.243.142]:33283 "EHLO
        probesys-mail.probesys.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390867AbeKWX5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:57:23 -0500
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Nov 2018 18:57:23 EST
Received: from localhost (localhost [127.0.0.1])
        by probesys-mail.probesys.net (Postfix) with ESMTP id 8B52C22419
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 14:03:48 +0100 (CET)
Received: from probesys-mail.probesys.net ([IPv6:::ffff:127.0.0.1])
        by localhost (probmail2.probesys.net [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id dpYoDDQvS86N for <linux-kernel@vger.kernel.org>;
        Fri, 23 Nov 2018 14:03:48 +0100 (CET)
Received: from [10.9.0.58] (unknown [109.190.253.11])
        by probesys-mail.probesys.net (Postfix) with ESMTPSA id F107D21388
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 14:03:47 +0100 (CET)
To:     linux-kernel@vger.kernel.org
From:   Zorg <zorg@probesys.com>
Subject: unsubcribe
Message-ID: <b5134f13-d6a6-1632-b537-2a9249e78614@probesys.com>
Date:   Fri, 23 Nov 2018 14:03:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


