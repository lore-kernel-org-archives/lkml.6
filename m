Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280BDC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0B02081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0B02081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ze-it.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeLKKwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:52:02 -0500
Received: from vie01a-dmta-pe06-2.mx.upcmail.net ([84.116.36.15]:47003 "EHLO
        vie01a-dmta-pe06-2.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726114AbeLKKwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:52:00 -0500
Received: from [172.31.216.234] (helo=vie01a-pemc-psmtp-pe11.mail.upcmail.net)
        by vie01a-dmta-pe06.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <thomas.zeitlhofer@ze-it.at>)
        id 1gWfdt-00083x-Ut
        for linux-kernel@vger.kernel.org; Tue, 11 Dec 2018 11:51:57 +0100
Received: from localhost.localdomain ([80.108.25.171])
        by vie01a-pemc-psmtp-pe11.mail.upcmail.net with ESMTP
        id Wfdtgq1aO5WeQWfdtgRsUO; Tue, 11 Dec 2018 11:51:57 +0100
X-Env-Mailfrom: thomas.zeitlhofer@ze-it.at
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 80.108.25.171
X-CNFS-Analysis: v=2.3 cv=YaJsGDZf c=1 sm=1 tr=0
 a=cw3iLm2b3cPoAt0NIr38/g==:117 a=cw3iLm2b3cPoAt0NIr38/g==:17
 a=kj9zAlcOel0A:10 a=tclcd6dtLQvEqt9_mmAA:9 a=CjuIK1q_8ugA:10
Date:   Tue, 11 Dec 2018 11:51:53 +0100
From:   Thomas Zeitlhofer <thomas.zeitlhofer@ze-it.at>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, mathias.nyman@linux.intel.com,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 014/110] usb: xhci: Prevent bus suspend if a port
 connect change or polling state is detected
Message-ID: <20181211105153.GA30952@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129135921.817957465@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Envelope: MS4wfNe70YkD44hD6xnh928awvqz8S1Ao7+c5a3SXPM6d5rI4EqzTEuk7n+Th4pbg9GZMqkKynP4MtJzVjJLTqLvw0pCHrZBH426PGSDdfy03FFocjaUPljJ
 XJj3Wh5UahMANEOLHccYPMh5Df7PDwncGHwiIOM0Ky8th2Ms/Nue7EU6B340mjaRbpVQ4d6SUAd8ecf/RPPlSxndCjwqvueDZaX1e21IQenYZrXZQWfikTtv
 N9gNre2remrhYbvEKPf7zJ2trYfslA9527tS9OdPA9gZBvAGUYc7IkxWcDBe+ywPEboZLBspsa9CSKDj+dHQsA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

