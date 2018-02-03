Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752736AbeBCRhC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 12:37:02 -0500
Received: from mout.web.de ([212.227.17.11]:60285 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752606AbeBCRgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 12:36:55 -0500
To: linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/6] HID-Prodikeys: Adjustments for two function
 implementations
Message-ID: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Date: Sat, 3 Feb 2018 18:36:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:mZvbURv6r/3PKjUKd60aEXttgR0BqgWB8Xq9qc22ilJTxx3QdMi
 sI5LkrqMj1gF8RC4ybUIbT7vwM4MagrKEXvGBjcyQ+LSwbk40xBj3+BhKPyplYiqi5SZtcD
 h4w5o+i2HKTz6g+yVAEYBLtCMw0A1dUaWyCXllwjUR3Qv08AVsgWy9UgfCfGeeli3YtaraT
 QUTqM3hGKAH1PyT0qRCBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nd1qUHjbaWU=:vEJvf+TWBXhQejMi1NYQ1j
 SeRVMHoHkYW+EHngC5GP/A0W/4ttW4RSSt/hhQ0Hxf16RCAfUp3yCthL0pXy9WcO76npR11j2
 SdgP4RSYpM0l9S5q71XAeav3wibkSMT6VP3es8V6oy1x3f69KmoVdBhYt8++lAZhKk+tB0DbD
 fagHZFBAQLihcbNu9n4Wwy+hykqvI1WWNNbGWfjyD0qELHlTOwqBjUGRwisby8t2QzqH2YoVA
 lyM0kMxhQyXz4hDNAyEGxRritmbtHBZ6rCgy73haEYupNXj+WlelDD7+wxeWKoe78weSBWF5w
 /WGoqsn50b74mFeHPioP4fKx4y2p+AKxXdQA7NtLQiwva8XXrYiVThZHe7Fw7u8aHYKzzR1Z7
 9fi4Wvz2N9oRUl5D1LQrQUtjON3UT1ZYiK1G0FVV5/TtSKzUY9aeezvUS1zmE8fEWjj8v5PzU
 HbNauGuLXs75jDsPzpV5RrEIG5VEl16OhDz6rcOv7k62WgrqpCR+co+Ns0oKHEL/5jfPSXUWP
 VSUalg78Q+zntga3uHK5+cq/Pes4qlj0KoUrDRLl9c8VjnuH1biJvS2jydllijSXoslXnAWoB
 r8s8Hy0Beb9kPNzAYkqV/0gVAd3JPfM0B6kcs7ZDcK09jGItZ4IslKy35kd0JuzJ7+1rMnFpM
 kc8Jt77Ow/7y+vSgiT8YFl3GIBPF4t7QAPy/AwFRSlC0X3OdTR6eciAQmj4gKFIuf8UppJziL
 RmoCe/8hBwKLmhFwciAB1xae6vhUcGmRHpiavcAIjHpCsOBa9nM4STINiXvtSjvEX0q/8H92n
 WVtsR8iDryut/P/jL/JNnFn09PcZf44fQqybUjivaqhg7QK1kU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 18:21:23 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (6):
  Delete two error messages for a failed memory allocation in pk_probe()
  Delete an unnecessary variable initialisation in pk_probe()
  Move an assignment in pk_probe()
  Delete an unnecessary return statement in pcmidi_send_note()
  Combine two condition checks into one statement in pcmidi_send_note()
  Rename a jump label in pcmidi_send_note()

 drivers/hid/hid-prodikeys.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

-- 
2.16.1
