Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F43C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 02:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF27213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 02:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=moysports.gov.bd header.i=@moysports.gov.bd header.b="gu5vATYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF27213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moysports.gov.bd
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeKUNae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 08:30:34 -0500
Received: from zimbra.bcc.gov.bd ([114.130.54.201]:55692 "EHLO
        zimbra.bcc.gov.bd" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeKUNae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 08:30:34 -0500
X-Greylist: delayed 7058 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2018 08:30:34 EST
Received: from localhost (localhost [127.0.0.1])
        by zimbra.bcc.gov.bd (Postfix) with ESMTP id C9978723E3E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:35:56 +0600 (BDT)
Received: from zimbra.bcc.gov.bd ([127.0.0.1])
        by localhost (zimbra.bcc.gov.bd [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ioJUVSJsgzbz for <linux-kernel@vger.kernel.org>;
        Wed, 21 Nov 2018 06:35:56 +0600 (BDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.bcc.gov.bd (Postfix) with ESMTP id 900897A9798
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:21:30 +0600 (BDT)
DKIM-Filter: OpenDKIM Filter v2.8.4 zimbra.bcc.gov.bd 900897A9798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moysports.gov.bd;
        s=B2A8F2FC-64CE-11E4-8712-5197EC8F47BD; t=1542759690;
        bh=6Ab0YTP4AmKSo8f4iHHpwFrcyF6+zZ5YnfI0ZxsAcrc=;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:To:
         From:Date:Reply-To:Message-Id;
        b=gu5vATYA58qNfIaCSddQoP9wiEWCksRO6xKpNHy4OKadEsc5eA2f2uOCr4DGPPlCS
         mcwONbq03A2gHBpu0s8eJyk+jh1AEkRMS0CF5lBgnp4pDvt3Fkg/4mWOG0fza+sGMj
         UMEhP1xME0Pmk8PDV65ZD7cMtl5W0tQLXPG3guD0=
X-Virus-Scanned: amavisd-new at zimbra.bcc.gov.bd
Received: from zimbra.bcc.gov.bd ([127.0.0.1])
        by localhost (zimbra.bcc.gov.bd [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4XYPlhEKWKmt for <linux-kernel@vger.kernel.org>;
        Wed, 21 Nov 2018 06:21:30 +0600 (BDT)
Received: from LAPTOP-1RVQC80V.Home (0545f2ec.skybroadband.com [5.69.242.236])
        by zimbra.bcc.gov.bd (Postfix) with ESMTPSA id 7F563467AEA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:05:43 +0600 (BDT)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: hello@
To:     linux-kernel@vger.kernel.org
From:   sas.budget@moysports.gov.bd
Date:   Tue, 20 Nov 2018 19:05:41 -0500
Reply-To: w.cadu2@gmail.com
Message-Id: <20181121000544.7F563467AEA@zimbra.bcc.gov.bd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Please can you respond to my last enquiry.
Thanks
Wayne.
