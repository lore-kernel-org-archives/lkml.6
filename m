Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8796FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF4E2098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF4E2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=winterdrache.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeHXP6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:58:36 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:43058 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeHXP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:58:36 -0400
Received: from ninja ([83.135.210.22]) by mrelayeu.kundenserver.de (mreue003
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MLTC2-1fsdAY2k1S-000YtC; Fri, 24
 Aug 2018 14:24:08 +0200
Date:   Fri, 24 Aug 2018 14:24:08 +0200
From:   "Matthias B." <matthias@winterdrache.de>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: How to report kernel panic in 4.4.x
Message-ID: <20180824142408.6340d052@ninja>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Y1bPTJEXsXf1PBYhnfIsSWOnx6E6nVl7KM7eWmPFstmB2XhQVSC
 vn93pMnG3pu+VSk0JWauRmHCBYmi4iCeq3AtMwcil+qf0UNXer/rkRu4TSKnKu546XP2W8B
 vhSdCAI1QhFhzwJSeE2bcFynFe+icGs+EgyA+4rFg667uzpk9Ch/TUjOd2aBaFwxOx3l6e8
 kkpY1T2WsRRRulVd6wWXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KeuGs1Yrxaw=:w09z2lbjtqdnlnlweSwIdN
 5U16Mtpvw6oJ8veh3N9u282zOsNd6eKLEDl9m69XkXH4djbow4kFdE5omHbWbe7xmiHvCzAzm
 VTYShKHxHf7gZ8RPlf6JNRyEw8oKGzGltUUlvSyn48/6NZb4YicSrDmtBkIHnSzmhQ6pvmDH5
 eZzjOKYW8pCkjNeQRnuyLtLYFvWc4fRfgq5YSe8qAuvPLPMXPfihG/FAf0fj3wC7vHXstJR9a
 IXZXaTzh2kG60K+Fa3AznLRlCX0deKs2+TzJ3MDzHV5PMgXbzbM7J3MmvaXaIBWTLa/IlimrS
 if5t48s+t5DnB6dOcBA3Xccj1KfgcMaNVNqYHOIbHIQcHiDQQEErao+/xYmMDbLu5jwSYQGAf
 OC2RuK5kziWqAVsCuG1cPY2oxnAoYU8IvX2ZclgXcagOmp/qDMVRhQoLD8Wx7zwXgALEhM/Js
 sRJ02n4WjX3W3+iTl9vNfFCTU+3p1C7uSCqf366JgCkgs7bXqWeBWds3/gzjE8lmAZyGHPqVs
 le5zsu/uEHe69lrT7vLibLthB1QAWuK6GoTcCMVcXX/AEhq9i+dhnK0lVVLGIccLArXicmopU
 aypmJ9OZdiNFdRPZBwEXIOSNJzK3e2nGhigLtkOIIjS2asihL3QErr8pj8D817gP/5QoJEWa0
 4pMqFwqSOsjA+3gIKGorHXxj/LHlKRuor2yFisCvzdjyzx79XxTrgMSuJyCI06EmKDDRDN0aD
 OAE5Q/mGpOaafycl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

4.4.147 is the last kernel of the 4.4.x series that boots for me. All
subsequent versions panic on boot. How do I report this bug? 
If I'm supposed to use https://bugzilla.kernel.org/ I don't know what
to fill into the fields. I don't even know if the longterm kernel falls
under "Mainline" or some other tree.

MSB

-- 
Fun chemistry experiments:
Sodium chloride doubles its volume
when combined with an equal amount of table salt.

