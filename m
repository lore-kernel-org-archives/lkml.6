Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D886C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7136D2174C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7136D2174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mesa.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389211AbeHGPnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:43:13 -0400
Received: from doortje.mesa.nl ([83.161.67.157]:36274 "EHLO mesa.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732703AbeHGPnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:43:13 -0400
X-Greylist: delayed 1648 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Aug 2018 11:43:13 EDT
Received: from joshua.mesa.nl (localhost.localdomain [127.0.0.1])
        by mesa.nl (8.12.11/8.12.8) with ESMTP id w77D1UbC007785
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <linux-kernel@vger.kernel.org>; Tue, 7 Aug 2018 15:01:30 +0200
Received: (from marcel@localhost)
        by joshua.mesa.nl (8.12.11/8.12.8/Submit) id w77D1Uhe007783
        for linux-kernel@vger.kernel.org; Tue, 7 Aug 2018 15:01:30 +0200
X-Authentication-Warning: joshua.mesa.nl: marcel set sender to marcel@mesa.nl using -f
Date:   Tue, 7 Aug 2018 15:01:30 +0200
From:   "Marcel J.E. Mol" <marcel@mesa.nl>
To:     linux-kernel@vger.kernel.org
Subject: help
Message-ID: <20180807130130.GA7773@joshua.mesa.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

help

-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868
    =======---------        marcel@mesa.nl                 Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,     Linux user 1148  --  www linuxcounter net
    so they gave me a name!  -- Rupert Hine  --  www ruperthine com --
