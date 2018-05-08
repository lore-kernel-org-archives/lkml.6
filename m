Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525789501; cv=none;
        d=google.com; s=arc-20160816;
        b=n2rBSIOCCDRv4sYiIlcZbPboAMiR8QmwYNAtgYpRDegwvBXYKWfEzkcs0lbK/REFId
         fxWJ+6GS3/ukQONJS3YiXOhc59zJVJNqADlFUhuSAgwuwyM3rotY8ZuOxao7RT4n8ZnU
         s15ea13CpsiRLW2QyZ1v6dRS3iI9nBrvN+3bb0t9xqzvraiDSu7QX7fZOV6ANazvVIzC
         GVa/ewcm/8gx8Nq9Yzjdvz3K1j8JSVqGUyt3ZfGV+sagOEn5dlSObwDKg/AntfK8o5wA
         7jeTpBq9EpGuJmE9XFwxlEcPGq2iI/cY0KEBtT1lWD8XQGIzU55RDC+q82q5TCGqieXH
         v2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=bhee0qmqCA6Wj9BtSpeAyfqDIoY4/uT2iH4uthEWIAA=;
        b=vFbcPcCBTudSMWuLE59Sl0WuEb4d11lChv/wILqj/SlvpVxY4IPACRlxg9d7U2vTI8
         U29xSCYrg6E/AnbXBwBCGdGrklLlmnhW7/1a/kIbrtUj8KNA1SmiFyX65f7Saz0WxER5
         Zf2Pdr7VzZHkbZEho9ahYNVfgWF/nEb4T9/TFOVhGF+wmIjCZfOmJDZn6I/ProGDcvcc
         uFk9Zu5yHG7W6DCddzoFK0TCUiwn4gww4ArZGtuH6ILbMgoOCPDM88pgkuVrzTiXaEBj
         vb/KhM0TNWnZgpC+ASN9t64mtR8eFyHS0ajkvI2UBbZRmO8GAjv9Vprl+glECSLWmxli
         GZuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZpK7KuCa3eUvBePkJ9qZ4CUOv1mzTXYJzYGwjWVkWViUz6wSjLwyEcmiCZTT77qvRut+L66gw==
Message-ID: <5af1b33c.0ab81c0a.b2308.4161@mx.google.com>
Date: Tue, 08 May 2018 07:25:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.98-33-g6e28bacfe4aa
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/32] 4.9.99-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599883077500588538?=
X-GMAIL-MSGID: =?utf-8?q?1599906252588827812?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 103 boots: 0 failed, 97 passed with 5 offline, =
1 conflict (v4.9.98-33-g6e28bacfe4aa)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.98-33-g6e28bacfe4aa/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.98-33-g6e28bacfe4aa/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.98-33-g6e28bacfe4aa
Git Commit: 6e28bacfe4aa523ece3838a9d50e7612d41be723
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 48 unique boards, 22 SoC families, 16 builds out of 183

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        tegra124-jetson-tk1:
            lab-mhart: new failure (last pass: v4.9.98-8-g5918d4b6b7ff)

Offline Platforms:

arm:

    multi_v7_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab

    qcom_defconfig:
        qcom-apq8064-cm-qs600: 1 offline lab
        qcom-apq8064-ifc6410: 1 offline lab

arm64:

    defconfig:
        apq8016-sbc: 1 offline lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

arm:

    multi_v7_defconfig:
        tegra124-jetson-tk1:
            lab-collabora: PASS
            lab-mhart: FAIL
            lab-baylibre-seattle: PASS

---
For more info write to <info@kernelci.org>
