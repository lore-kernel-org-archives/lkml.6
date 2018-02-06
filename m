Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeBFQPJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:15:09 -0500
Received: from mout.web.de ([212.227.15.3]:51085 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752650AbeBFQPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:15:00 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] HID-Lenovo: Adjustments for three function
 implementations
Message-ID: <06e2d590-f980-0022-c476-6b999239ff9f@users.sourceforge.net>
Date: Tue, 6 Feb 2018 17:14:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:U4s3fSvmxJpUXwvFqY0BR+fj775n6wDbqUgQMKGI/Xgkkw7cvr5
 edrOqxhzevHmIkdVJzRB3KLrSCGTvcuiqZHkMxCd4JHgQgquuncLa7zVDCUEx8duuA278bJ
 SiqnGQ443jXMf8RHi1ETqCO9ZBMB5PZvKdwO3eMPMf1Vr/9AICMdnTnDkZNItobWau8gdMk
 F8LBd25AYrhhyQBKLxloA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R8CPy9PSuGk=:4HvrePYF7tcZgrZVCozUF+
 HVqQ4R2gnBAMK+/gctFfRnYL6zux/AHksLQhXt1VpPvzh6dxzbDDVjZGouBv6DsG1QFSw/Cqg
 C43xiw/OIa6T4CbmMYaQA42Ly5Eg/9LdBRyiNX6rFxnNdUm8TVhFVkbJqzrY6jMNsYqw0r4Cc
 UyNQVvk8x4GeTqcdTgzcHVwbWLpD/IlaCr3dcTI8dDcSxITZBz9OfHseVI8aPWQMUde27lpke
 SqGsLoYlUNVL+exsvGubqvD7JecNj99hnDTfAqmVaQDMmaj1dD730p3kl7IEnWYtj1qwkH27A
 gAAgJVrMvRSYgY2++roaJGM5WeVjxBOPGZiHdfnoeZT5Y2K75md3PTfe290nGVAAFqOpzLXTK
 baeRpxifCG6sDI3rRfgXPETZCYzZV80iuXTyiI2R9zPM3rzFdmR+u4s1gUhSJQjKC/sUJivLw
 1pkYfAs9uJCvKtyduhiCywKShxFwQYU4Ra106t7l08aiFi/6ml4gleNWpzYbEnCwE9f6A1svS
 tA7SCVRCPLK7T0oZDWoFJDVfTweWLUoPFrcNxcYsSZrUcvAZjD2d3jS8qyY+uDfEEsEp4GyJN
 Da5l6ndUq1ho0PGa9RiQQ+TeqYFSDfMTmhhUIL9gyF0sQoOz1hIuTGfggEuCfYVzQRrGscV8y
 JzKwu+Xtd+xYozUBxD4qVWddJBVWnC8ezXZfYJxnox3x7ftFNP2/oJNSeR934pO+HKYDck+XM
 bkuW4ugNw3qca5+LKtrvR80d4va1/3fwzXg4vlieJNJGvCf7SsnQkD9PnOgA/eOzOZyV89ED4
 blK2CAwaC1G1J4VRS92CF3xRbV4UEaQ+yZFIErjqpKmzzqvTUE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 17:12:34 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in two functions
  Improve a size determination in lenovo_probe_tpkbd()
  Adjust four checks for null pointers

 drivers/hid/hid-lenovo.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

-- 
2.16.1
