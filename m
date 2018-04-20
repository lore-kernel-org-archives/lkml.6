Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48hiM8BGhrM+EapqBi99UM2tBZsRT3YveVeG+KyZJLGkLijNxXqg8OtknbCJGS/pZNGGE8r
ARC-Seal: i=1; a=rsa-sha256; t=1524256436; cv=none;
        d=google.com; s=arc-20160816;
        b=A0mln28dTud+thb69Y+f4LNDJzVKDYRi4UgcXySQGknkeGgjjsS0zeYqXpqId3Q6Ku
         VMYr8A50cldKEaSr6OjBbQyz16RYc/NPT1bPaVAO3YVMomr62iDvAb7m/IDD7aDi+LYN
         ZSkndix4ilXZAKsrjyy5FOKJZlwwwrxZGfTVwbkLK0woNU/M5qbrDVHNmKvabxmL0HOQ
         JsY/ZgHaGb0DjyCFVRXdWFNPL1EsgUbVhqATHKESJqYn+CI9TF0v43Ufdq4A6KJBfP9s
         FeF/ZmAflbpcMezkb9zwSo2nPwyMwovurjxMP0fD1Uk3PPj9JhhQ9YsBOinUPpTcU60o
         mb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-language:mime-version:user-agent
         :date:message-id:autocrypt:openpgp:subject:from:cc:to
         :arc-authentication-results;
        bh=DVpD6A7qM69EMGmbA7uoY9d44Kmx91eY0KwnY9cx8v4=;
        b=wJsbJ+wIySpuDs0VMQ7YxLbwcFhFNgt3x0g60kTgVpdj1KSpKplRRtjI1OiIM3BAYz
         ZzpS+ZF+urJ4+ofu69M9faf0sBaLfIA+6/FGHxWxhvFu4WCi4bOpgPwAPXyeLZKzM2kf
         qSWp/m4S1JbiLUg6dkRHjGAKqZj9o5Noowqr1cyhKLABtZBoWBqElc20h6D7+K6gTzKl
         6o+KZhe7QPP7iQIdhDfhs62A1cxGEIojYIUNJVPrp6MHsTx4FKBk8gJji9Mw7hQIPYo9
         8qOlzifXMRhn7TgQ9qIMeRGgsURkW8pRtfIG2ehrruiPbzW/ZFMUbdcAkhY4UoMpkGHb
         hh0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeDTUdz (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 20 Apr 2018 16:33:55 -0400
Received: from osg.samsung.com ([64.30.133.232]:46293 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbeDTUdy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Apr 2018 16:33:54 -0400
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        christian.brauner@ubuntu.com
From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [GIT PULL] kselftest update for 4.17-rc2
Openpgp: preference=signencrypt
Autocrypt: addr=shuahkh@osg.samsung.com; prefer-encrypt=mutual; keydata=
 xsFNBFIzbI0BEADtNDUjCT2vg2pVl9+XAwjq43AnDpggRIWjq8c82lcGgt9WYeQ2ezoGHADx
 9XS5dP8OUdf2e1j2GtxOA9DpuAE6KNp9q4n2WHl9Q6Y06JwaXcMKlqH1WzAu8QWDou8KC8UL
 k+Ma/80uqlwQDmy+SDuLSLSPXP03P3NfKII8vAdREVTDfDzle+IKXDgYB8E5On1533QNVXdH
 rWQOU/SggOF8pGklv/a8VMR6KUYbkkkFy9wGLSLeBUx6ZfRkZSYBcAinwHLqWyDGB1993l1K
 y/FArlfEYLjKZ9od9ZGmnA3Ww9EMqpUUTP9b7a/sNuBhmsk5WVwMhMEtCxtIxHj0PVX8+m2R
 mj7mvdBukwsBOfu4ef0tK8CJHUNOXpWwNEl8LY1S+yJS/AZuwvzjpmfNQCzdixGG48oAeb11
 9YKDCAUP0gjI44jZOiWb38jUn1SGqphW4i2jSiDi9R82mCtrcEXFHUuom2aRGyXEVdL9cEor
 9/e4uaLDDZPGI4QqlbH6VoJkLzNFTAZnCKW9UsPXonQ7lP9hzH4+3sekYDkpmm2FcIXfVBRC
 XQPri2YuJtk/tgjuTC/5Y+b1itiI/xuKj7YmTYwFICUjYF9ehNe/6giG7zYZPIp2cr+oKwW5
 OTo49wqTdUVm84gULn90p2YQlXnbcw81l+K09AvGj5BntvmjDQARAQABzSFTaHVhaCBLaGFu
 IDxzaHVhaEBnb25laGlraW5nLm9yZz7CwXoEEwECACQCGwMCHgECF4AFCwkIBwMFFQoJCAsF
 FgIDAQAFAlIzc34CGQEACgkQCwJExA0NQxyAmhAAiIg5u11jeZtK2T1cGqITPyrzMg+Mu5WB
 /8xKvbc8wYuStJ6mn84zedBzAjjpCUpdZBfGKGV4Piyj6RyVtPOUe1aze7xNl6jq2XodyHpz
 yCBpVozvQGlWdSO34vTA+iwmbQat4DDHoIjvuGf2gqMzSNXiP6KG0erKOP0l5wBGOgjRtJAn
 6LSrxC/q7M0OKdSxOQpLd9JHc9MPhjRiEHJGxRTYwb93kzJVZTYVIi5ns709/VvR9dA2kcJx
 mE7AxFduFYEkndF1eS15YRHzPUgH6qlcmpd+BqFDd9Xr4qlEygcOKbUktAbi0iqGJZQiAm7k
 Bc1C/WLVmf6w1Hmd5kc+9JU4nYN3LzsvUHVkzY+XqaTkYYIlziRec40XvIDE6J55ByJYTO94
 iBswwY7IwcxL1qUWrBDvJC8jJFtZw+hcuCZr8cwH9UpFRPejZ2iuXycLagtYAe6ppor8uepj
 FB3yJjrFwwe5XSxjAQyBRvGpzLjZTvSGfsJ6WUwE+7/my9Ab+wnDhebxEbyCuGoIQsNaA5qh
 JHL5xXEw0yVrYSiuBTuOVyTwZvyisvOWAnehIlVok+Oq372vjXitfAr43doeyKoQJkpKdcgD
 wMfU2Sxbiqvfqid/9g+GaySvA9jnkO11INvUqQAnFwQ8QjmzRCMRVK3/ZP4lQ8d4rkks+Rsy
 7HvOwU0EUjNzxQEQALrsbTCFLIY0/JmCNZ4Wdy6iWdAYjLBqKVxLQ9hBD+y8cQ/tF183XfP/
 oVQrRHiJXJHFN94KjL05g9ww4HHoqSq66f8nYFBtZ58kvhY1qgZDbnXaraz5dTN+um5jUTNp
 jmnqmVRiEs+UredmKUIQkQOnbY+sZNUPb25BX6ebdQ0p+aiJysJtO6fi/Au2K2PIj26RmwAK
 L2+DGSqFR183N8/XTBtb2qtFsvm1hO+jUtt7MB6+jf35AR+CDZd6c+ypqO+RpoS3G+5Cbiv0
 D8jMQxWgZ8MTxAKlI5aUT2J2ep+cQxnm8J1NXM996MkUZE8+6CFeH8y/JftlsZ1dvaBs4eHC
 UqeE2xc6dFxrftDuDlFTtEDGCPmd/z5KWUAM0yX+pJXUiu4ljxtu0drdo/QfcNf4RTSw4JoI
 WE8WjHTnONfyMW860qJknddYB2/m+tpF4C/5ocNms3SaFYnMPOu1orn3imBMEeYmiX778FU+
 CgZBIlftMwcY2+3EeWBTjbJdZnhJ0jD+akLRnjJWUXY9RtxYLS2D7nFZCiUiwjGrh+ctEs7U
 we4in7KOb1lZKykrH/DM70HgKRkSHnFqNSinbRA2ty8QoE04RIy56JNNgqDSthlgW/aY7Q4g
 d70eu5/GMuqvMAa8ONceuJZ6vEZ9vvPL0Boolac+I0hiS71KqqpvABEBAAHCwV8EGAECAAkF
 AlIzc8UCGwwACgkQCwJExA0NQxyxXxAAqaLaK7pYT+z89HDsIrgWIbOv1Fr+LuEWYLk9UFEm
 Y0S/Hl7WIII1XHnspeWauaA6XDQ14Lyw7ywmhwhbwfUPC+W2UXRZ/6azE+pxJYcde41pLXgY
 vBHrvs2thzsZNUHslwHoN/tNwRZLpg2tbRVCbjV7/xAWXl0WCmvOd0C5yMVKx4oQ6/Eg1EaW
 TiPpZ5DM0TKBQ99nzwx8yQs2AZSzgl/mx0e9jWFzsn0XiH8DJKiGK5biKiHN3gsorEULkAje
 /GqbYDQuHbT7khmKiLtLcXktV8OVTGAg+cJaHtmpRSUQ16Gji4IkZCt0ZTZclAs2EstECa5a
 zuehlSFo7wmVteR4/ox+qJvQjwI+CU2l4Rcz9l9QgAo5bhW74oQ4mcN3o9OzRo85e8DVaR8K
 jKe2BHpSRV7mpiRXQ/t7sNKZN3w8mMIXzq5xa+TFWaVHJfOLwKvtFpL/7gRBZV2+yqV/J35b
 CjTFOY1/+fA5hwODGBz/SiHv21t11Nnk6yg9Solpc4HG47V24h2lTwlEfIUTpuwhYG+LBY48
 uPJXU+CdBcyHUwWSA/O1/vXMuJ6byXTbcwtrwBnIO3hoBfxIfGVIgzjwI+/PkDEyn3m0+IAX
 7ipOURNtfmY71UIeV+kk2j9tHWlcx8yOmStvZ3JFpAuqgZhrDa9aAlaq9GyT/t3HsKs=
Message-ID: <4c8657ee-d7e8-3e87-05fb-57de6fff13e2@osg.samsung.com>
Date: Fri, 20 Apr 2018 14:33:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------449CC5B777BA75A09DB57954"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598298717288101554?=
X-GMAIL-MSGID: =?utf-8?q?1598298717288101554?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------449CC5B777BA75A09DB57954
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following Kselftest update for 4.17-rc2


This Kselftest update for 4.17-rc2 consists of a fix from Michael Ellerman
to not run dnotify_test by default to prevent Kselftest running forever.

diff is attached.

thanks,
-- Shuah

-----------------------------------------------------------------------------------
The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-4.17-rc2

for you to fetch changes up to 8bf24e8319613bbe950d4188682b3a0d9441b76b:

  selftests/filesystems: Don't run dnotify_test by default (2018-04-17 17:01:16 -0600)

----------------------------------------------------------------
linux-kselftest-4.17-rc2

This Kselftest update for 4.17-rc2 consists of a fix from Michael Ellerman
to not run dnotify_test by default to prevent Kselftest running forever.

----------------------------------------------------------------
Michael Ellerman (1):
      selftests/filesystems: Don't run dnotify_test by default

 tools/testing/selftests/filesystems/Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-----------------------------------------------------------------------------------

--------------449CC5B777BA75A09DB57954
Content-Type: text/x-patch;
 name="linux-kselftest-4.17-rc2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="linux-kselftest-4.17-rc2.diff"

diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing=
/selftests/filesystems/Makefile
index 4e6d09fb166f..5c7d7001ad37 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_PROGS :=3D dnotify_test devpts_pts
-all: $(TEST_PROGS)
=20
-include ../lib.mk
+TEST_GEN_PROGS :=3D devpts_pts
+TEST_GEN_PROGS_EXTENDED :=3D dnotify_test
=20
-clean:
-	rm -fr $(TEST_PROGS)
+include ../lib.mk

--------------449CC5B777BA75A09DB57954--
