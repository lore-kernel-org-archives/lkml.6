Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeBEVY7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:24:59 -0500
Received: from mout.web.de ([212.227.15.3]:39247 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbeBEVYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:24:52 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] HID: logitech-dj: Adjustments for some function
 implementations
Message-ID: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Date: Mon, 5 Feb 2018 22:24:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:xf+BZAT3AEisoM6nVDK7EahrdFnBIHKqdt0HfKhr6zmYLUmf8gB
 qqUtNkFucPgHDtq+fDh92B38vj1HCX/VMn0K2JYNvreaFzX08QxLCmzafvoJs5iygTr69CB
 BAFfCCeiFTItWg/UtPJ0p9GItSDg3PMLhVoVM2wQTRCezsaDdNJqdvqt+aPuAxyJo8Puthl
 2qylqquLmua2yE4MX+iuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DRVtAtnnQ28=:hHyQcgdxDYM2jpGGRginCx
 QAVCDwx7kNAG1Oc7Ujv1CTEmMCpz9gAa0L0QRsuSGUkDMfmyurRVPvb9h8/WmN9LpalAYMwhO
 G/6y382w4Lo5JKnKMzwcADs97DG+6bvi9COyo3ddXSB7H4JKDuKYtMxhOEl5QWFTTMQHy2a4x
 lPqEeNcIZwXOeKR7QpqUM5VeZ9NPID3phJqCj1mJ+FKB8+cK6P0kxtrTIR/imm+vqiuvq01QI
 avbl54e7uCg7FlqH1oGswROF03SFYtlroVj8nKxzwGvacX3rWERmcyKA+OtA9QgSuuM8g543t
 odW9Ikz1bc36qamAcY8dagE+xHbytSJDz+6/gPmnbT2KlQfBLQMDZxOKv2W2ZJ8TF91og49RD
 Nf6w2i9fo5hsrPxjM7NYgQEya/exZti7Karcs5zVBzzwlSl3gdKEltlP4I89bv3AaMSRVfwai
 iprKVaN+HKCowQuhb66MR+dvP76JdMkiaWZJXoN0odSMu9ZCKT1io5svJ7aAKeYJtAmNlOWx0
 hFaMhBtxES8xrOj/bPwzJ2G2fbLzBSb6yeGsqtBkoxCGZbJN+qm1InJ/Zqvb+Zkxmt5IpaUzc
 wO2Q20QbrCmjpgNwSdawP2cB//Yrprv2f08cc3Q2YxWTNidcvyRtXLnF12RAkRvvKiWJ0+Gwg
 UhcSR1fSvLlKfQbuT/skJWSjQYjJ054lrX72ydgxLHIQoVmduyuXI5UzFptCuoxa/r3q2/Ja0
 YBEO0z3BoJzxziTSVFNWWRkuMbZNm7HINLXTdUujY7icuLEDjm1afJQ/isEvZv7bQkBBdJQVO
 U0i9U0SiQIOumzG5MF8EjQyc9FraAG51laiJYnpKOwJjx0nkN0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2018 22:22:11 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete an error message for a failed memory allocation in two functions
  Improve a size determination in four functions
  Combine substrings for seven messages
  Fix a typo in a comment line

 drivers/hid/hid-logitech-dj.c | 53 +++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

-- 
2.16.1
