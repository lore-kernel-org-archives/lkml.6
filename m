Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526303132; cv=none;
        d=google.com; s=arc-20160816;
        b=Kks5Jh3kNqyoNiworQHl4yacBJ5YJIE1fLg3/cxVuNrGutWs74SHXrToXTPtPvqj7f
         2qIL/w/fw/ZvzU471do8Ar2QUzwr88V7AnF9yHr/FXhf9kbcB84HJ9p/ogGKdJ7hWezO
         c/SLajO3Z/j1FpWfgdHsROdjK7FT02PCq2baCgJWaxGjpQOHDDXrdVl9ikWyKu8YWAoH
         JZRtsNQ8e3/hZUZuoyOlAku5sIFXKbiZHtTAuqWo/+V0AxG8qWTBQTeQIDTf3Oauuohg
         CjBjPzcyu2941cAA3WRZJp8aedylF+Z81so8lNI2G1aiY4BAmhhz8QrXKaQmvtyLKi3Y
         n/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=uG2RXDwU/PZNJbERO0BeEMKM7qmA5VQUdYtCUoXhweE=;
        b=Jl9Ana8j7jfArqCQeO7G+rpEOli2Nwf86NtTNDbd6LzqyyMyLr7bNMys8Egbfnz44M
         IQHURZhsrmmrara4KqwkpcT25WsRqDl6L1qnxNlz68o7wQMoQa4YvA9HvHx/AXE6tUX9
         DlfwNGKVSPtw2fk0kuFqaxSGkrCkdYfjmpHGYGzxSzorwIPF8iYDxd7486CAVvTL4RbE
         2S2aHhcwHGLVEJmgMrNUX52+Ogn9rQmAFUJ8Qmfmvc2fYjLv7+ihFuZeFaZOBXqgvMgb
         3NCmtjELTFjdeQYGwUJSx7R2tI4E8/DmXyRRvAW6dJutYWozTv+9z63hvSyZvahxkoYQ
         N5DQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZoWFJ7uIJFFyCerQMM89Z1PP4S88VgK9VBh29F/8t55B4mOF2sEd2qdH0UMEGoHftslPBv3zQ==
Message-ID: <5af9899c.1c69fb81.a2c63.2124@mx.google.com>
Date: Mon, 14 May 2018 06:05:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.99-37-g126d655643a8
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/36] 4.9.100-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600421456902813173?=
X-GMAIL-MSGID: =?utf-8?q?1600444833967077779?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 98 boots: 0 failed, 98 passed (v4.9.99-37-g126d=
655643a8)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.99-37-g126d655643a8/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.99-37-g126d655643a8/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.99-37-g126d655643a8
Git Commit: 126d655643a828cd86fd7d8e154aa397bd08b31b
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 48 unique boards, 21 SoC families, 16 builds out of 183

---
For more info write to <info@kernelci.org>
