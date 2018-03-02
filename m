Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519997937; cv=none;
        d=google.com; s=arc-20160816;
        b=lxScjWlFV7loS/pW/RkrFBXlZaNzQ8YO1FuAOvagfaDk6IUuGjXE+Wdli27kq5pKgz
         jnyRxYISxXAXARQsOLv3p/yXd7yTceh95KEm8rbm6wGzGqJORcy4q418RasngKG7GiX9
         dJSDxJgWFmTHD+g7DoMnFcJeBYf66tmGpwqH6krwuRQyf/YcffXgXTXFEHXtweu+mJaP
         px6xMn262t9IjO+FfA7Ofj6sRFrxTn3GcF56xO0NPQcTYIUuR7eLg1ANL+ttiDAoUc/c
         g2Y1vDs7GMiMu/OhXobj+gPQUSBrg9UGvjTJASooZihJtdh75eDtigEWV6YHQLiuuHZn
         7ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=SQKfedcfvQ9sFSZOSb+zhzEI5ZVpmwFuEB0dGNF0kxQ=;
        b=R/aVbCahBr5n1Fp6YyiTptRx2ksDcuvgAERSI3twQEg9lWtG+Z+ITSuUwSgkv1vffk
         1U0+xrmZ2cTXsgfYUzxa69MnC6++TY6xLY6ocjS9QJTKTgB+c+NuqQDndBxoWBZSQbLS
         0mBFW/BK+IIaeUVGnB3ID0zkKqdoipubFZtVkEJjyYlG2wzLHPkxqFVitHYDYcMogoDh
         4KULEEyIm9uHMi82n0NUccdClTT/nPmLcI9wNTZvWOUKQuGDektlTz0RgigLG6amLycE
         CrRYpziHiI5sFI6f2pHoagpKvVZHpQRx/0Rp6K3L2ZLLG0i9eVhQqsGcqKejDKg/PrMM
         w98A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELtMPteFO4z2p4rQY0PA+aAR/ugurw38cU+onAbCrwxC2bvAX7tg1Qig5D0srWJetp9Z9XEMRg==
Message-ID: <5a9953ef.d1e0df0a.2b4e8.dfd5@mx.google.com>
Date: Fri, 02 Mar 2018 05:38:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Kernel: v4.14.23-116-g0ae11358b0bd
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
Subject: Re: [PATCH 4.14 000/115] 4.14.24-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593815830874843893?=
X-GMAIL-MSGID: =?utf-8?q?1593833356510787851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 62 boots: 1 failed, 59 passed with 2 offline (=
v4.14.23-116-g0ae11358b0bd)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.23-116-g0ae11358b0bd/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.23-116-g0ae11358b0bd/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.23-116-g0ae11358b0bd
Git Commit: 0ae11358b0bdffc782ee655fd103b95cbcafb899
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 38 unique boards, 19 SoC families, 13 builds out of 185

Boot Regressions Detected:

arm:

    sunxi_defconfig:
        sun8i-h3-orangepi-pc:
            lab-free-electrons: new failure (last pass: v4.14.18-23-g8d861f=
5b27b0)

Boot Failure Detected:

arm:

    sunxi_defconfig
        sun8i-h3-orangepi-pc: 1 failed lab

Offline Platforms:

arm64:

    defconfig:
        meson-gxbb-odroidc2: 1 offline lab
        meson-gxl-s905x-nexbox-a95x: 1 offline lab

---
For more info write to <info@kernelci.org>
