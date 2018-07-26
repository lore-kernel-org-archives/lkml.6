Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342CCC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E024020846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E024020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeGZIPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:15:04 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:41736 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbeGZIPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:15:03 -0400
Received: from mse02.zte.com.cn (unknown [10.30.3.21])
        by Forcepoint Email with ESMTPS id 3473AD285B31A244690B;
        Thu, 26 Jul 2018 14:59:36 +0800 (CST)
Received: from kjyxapp02.zte.com.cn ([10.30.12.201])
        by mse02.zte.com.cn with SMTP id w6Q6xQkc003637;
        Thu, 26 Jul 2018 14:59:26 +0800 (GMT-8)
        (envelope-from jiang.biao2@zte.com.cn)
Received: from mapi (kjyxapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 26 Jul 2018 14:59:28 +0800 (CST)
Date:   Thu, 26 Jul 2018 14:59:28 +0800 (CST)
X-Zmail-TransId: 2b045b597150354ce295
X-Mailer: Zmail v1.0
Message-ID: <201807261459282984111@zte.com.cn>
In-Reply-To: <20180726061115.GR28386@dhcp22.suse.cz>
References: 1532561657-98783-1-git-send-email-jiang.biao2@zte.com.cn,20180726061115.GR28386@dhcp22.suse.cz
Mime-Version: 1.0
From:   <jiang.biao2@zte.com.cn>
To:     <mhocko@kernel.org>
Cc:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <hillf.zj@alibaba-inc.com>, <minchan@kernel.org>,
        <ying.huang@intel.com>, <mgorman@techsingularity.net>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <zhong.weidong@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbW0vdm1zY2FuOiBmaXggcGFnZV9mcmVlemVfcmVmcyBpbiBjb21tZW50Lg==?=
Content-Type: multipart/mixed;
        boundary="=====_001_next====="
X-MAIL: mse02.zte.com.cn w6Q6xQkc003637
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



--=====_001_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGksCj4gT24gVGh1IDI2LTA3LTE4IDA3OjM0OjE3LCBKaWFuZyBCaWFvIHdyb3RlOgo+PiBwYWdl
X2ZyZWV6ZV9yZWZzIGhhcyBhbHJlYWR5IGJlZW4gcmVscGxhY2VkIGJ5IHBhZ2VfcmVmX2ZyZWV6
ZSwgYnV0Cj4+IGl0IGlzIG5vdCBtb2RpZmllZCBpbiB0aGUgY29tbWVudC4KPiAKPiBIbW0KPiAk
IGdpdCBncmVwIHBhZ2VfcmVmc19mcmVlemUgb3JpZ2luL21hc3Rlcgo+ICQKPiAKPiBUaGUgc2Ft
ZSBpcyB0aGUgY2FzZSBpbiB0aGUgbGludXgtbmV4dCB0cmVlLiBXaGljaCB0cmVlIGFyZSB5b3Ug
bG9va2luZyBhdD8KSSdtIHNvcnJ5LCBpdCBzaG91bGQgYmUgKnBhZ2VfcmVmX2ZyZWV6ZSosIEkg
bWlzc3BlbGxlZCB0aGUgd29yZC4gIApBbmQgSSBjaGVja2VkICBhZ2FpbiB3aXRoIGdpdCBncmVw
LCBmb3VuZCB0aGVyZSBhcmUgb3RoZXIgcGxhY2VzIHdpdGggdGhlIHNhbWUKcHJvYmxlbS4KIyBn
aXQgZ3JlcCBwYWdlX2ZyZWV6ZV9yZWZzIG1hc3RlcgptYXN0ZXI6bW0va3NtLmM6ICAgICAgICAg
KiBob3dldmVyLCBpdCBtaWdodCBtZWFuIHRoYXQgdGhlIHBhZ2UgaXMgdW5kZXIgcGFnZV9mcmVl
emVfcmVmcygpLgptYXN0ZXI6bW0vbWVtb3J5LWZhaWx1cmUuYzogICAgICAqIHRoYXQgbWF5IG1h
a2UgcGFnZV9mcmVlemVfcmVmcygpL3BhZ2VfdW5mcmVlemVfcmVmcygpIG1pc21hdGNoLgptYXN0
ZXI6bW0vdm1zY2FuLmM6ICAgICAvKiBub3RlOiBhdG9taWNfY21weGNoZyBpbiBwYWdlX2ZyZWV6
ZV9yZWZzIHByb3ZpZGVzIHRoZSBzbXBfcm1iICovCgpJJ2xsIHNlbmQgdjIgdG8gZml4IGFsbCBv
ZiB0aGVzZS4KVGhhbmtzLgoKSmlhbmcsClJlZ2FyZHM=


--=====_003_next=====--

--=====_001_next=====--

