Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E211DC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA0721725
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=laytheon.com header.i=@laytheon.com header.b="MXSE6zWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA0721725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=laytheon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbeHNVjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:39:33 -0400
Received: from mail-ua1-f72.google.com ([209.85.222.72]:40897 "EHLO
        mail-ua1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeHNVjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:39:32 -0400
Received: by mail-ua1-f72.google.com with SMTP id y3-v6so10620523uao.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=laytheon.com; s=google;
        h=mime-version:message-id:date:subject:from:to
         :content-transfer-encoding;
        bh=Dy6AjRhp27+W2hugw2Tj1UAmNDXlP+rzLTuegUQOqC8=;
        b=MXSE6zWI+Ct1oOygIPUTwkFfEkiGt6QAZRLTNPnkVM/nNLlYC2JF6LB7JZoNu0xWPh
         vwME7l++77a6H+Qxxo1Wlmy1bxnHUf6xtlFM76KCGTR+qfecXxBvIQjgwdYakwkGZL9S
         IZzLmrR+8xuLJPg3N4Gv5mHUSN/55ezVNgpC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:message-id:date:subject:from:to
         :content-transfer-encoding;
        bh=Dy6AjRhp27+W2hugw2Tj1UAmNDXlP+rzLTuegUQOqC8=;
        b=HUQmyGLIsII1zcaRt+aqMrD9hbSKUr/l4Qd9Q4x75vIzOrNGehRVTC+BT+jwAl9J2g
         aDMfV8gwpJJihjCs0Nw2i3Lc8HvVGt+O6dsZ2VNvRaSSXfrIodMGTDgM9OAw4iOXYMFQ
         XtU6PI+gLPFf5pWoDS98+dM/5So0cwHV9xnTv4JFuzwu4L0hJXMjNiSeo1MrPCdbETgd
         x5qvw82z3jWuzD9HoJCoUI5W4WHNb44ILPF2NRbLsGkqpDGubRpTIc+q+Zs4lZDdFVZF
         hukFohI7jaAwSSiFH3VzEs+zwf/AhbSmY82XHi/BalUlY4vpsvBkOaikZeQfmzkgwlMD
         +7wg==
X-Gm-Message-State: AOUpUlHDyBy6hXVpuUFSERf/nTyUm29eXXenbToVGon0JpmR4ikGe93M
        vxpI4H6GDjDSS/hO7Egt17eWo5Ojdb+3
X-Google-Smtp-Source: AA+uWPyMnMRnYxLULNvmX2n4zG5OSvqCv6O4IZDViTLlo2d1vTHoRe1828ENafwVjG8W092l0HXOAIA1CA==
MIME-Version: 1.0
X-Received: by 2002:a1f:aa8f:: with SMTP id t137-v6mr12814113vke.106.1534272660290;
 Tue, 14 Aug 2018 11:51:00 -0700 (PDT)
Message-ID: <000000000000e7c4c5057369b085@google.com>
Date:   Tue, 14 Aug 2018 18:51:00 +0000
Subject:  Targeted B2B Companies Emails List 
From:   joyce.murphy@laytheon.com
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkkganVzdCB3YW50ZWQgdG8gY2hlY2sgaWYgeW91IHdvdWxkIGJlIGludGVyZXN0ZWQg
aW4gYSBsaXN0IG9mIE1hbmFnZWQgIA0KU2VydmljZSBQcm92aWRlcnMgKE1TUHMpIGFuZCBNYW5h
Z2VkIFNlY3VyaXR5IFNlcnZpY2UgUHJvdmlkZXJzIChNU1NQcyk/DQoNCldlIGFsc28gaGF2ZSB0
aGUgZGF0YSBpbnRlbGxpZ2VuY2Ugb2Y6DQoNCuKAoiAgICAgICBNYW5hZ2VkIFNlcnZpY2UgUHJv
dmlkZXJzIChNU1DigJlzKQ0K4oCiICAgICAgIE1hbmFnZWQgU2VjdXJpdHkgU2VydmljZSBQcm92
aWRlcnMgKE1TU1DigJlzKQ0K4oCiICAgICAgIElUIERlY2lzaW9uIE1ha2VycyDigJMgNm1pbGxp
b24gYWNyb3NzIGFsbCBpbmR1c3RyeQ0K4oCiICAgICAgIEJ1c2luZXNzIERlY2lzaW9uIE1ha2Vy
cyDigJMgMTAgbWlsbGlvbiBhY3Jvc3MgYWxsIGluZHVzdHJ5DQrigKIgICAgICAgVmFsdWUgQWRk
ZWQgUmVzZWxsZXJzLSBWQVJzDQrigKIgICAgICAgSW5kZXBlbmRlbnQgU29mdHdhcmUgVmVuZG9y
cy0gSVNWcw0K4oCiICAgICAgIFN5c3RlbSBJbnRlZ3JhdG9ycy0gU0lzDQrigKIgICAgICAgVm9J
UCBTZXJ2aWNlIFByb3ZpZGVycy4NCuKAoiAgICAgICBUZWxlY29tbXVuaWNhdGlvbnMgU2Vydmlj
ZSBQcm92aWRlcnMgKFRTUHMpDQrigKIgICAgICAgQXBwbGljYXRpb24gU2VydmljZSBQcm92aWRl
cnMgKEFTUHMpDQrigKIgICAgICAgSVQgTWFuYWdlZCBTZXJ2aWNlcyBQcm92aWRlcnMgKElUTVNQ
KQ0K4oCiICAgICAgIFN0b3JhZ2UgU2VydmljZSBQcm92aWRlcnMgKFNTUHMpDQoNCktpbmRseSBy
ZXZpZXcgYW5kIGxldCBtZSBrbm93IGlmIEkgY2FuIHNoYXJlIG1vcmUgaW5mb3JtYXRpb24gb24g
dGhpcy4NCg0KSSBsb29rIGZvcndhcmQgdG8gaGVhcmluZyBmcm9tIHlvdS4NCg0KUmVnYXJkcywN
CkpveWNlDQpNYXJrZXRpbmcgU3BlY2lhbGlzdA0KDQpJZiB5b3UgZG9uJ3Qgd2FudCB0byBpbmNs
dWRlIHlvdXJzZWxmIGluIG91ciBtYWlsaW5nIGxpc3QsIHBsZWFzZSByZXBseSAgDQpiYWNrIOKA
nExlYXZlIE91dCIiIGluIGEgc3ViamVjdCBsaW5lIg0K
