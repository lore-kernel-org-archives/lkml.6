Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525794302; cv=none;
        d=google.com; s=arc-20160816;
        b=Iopr00KL1MyErIrIYa1I4acstrcnT048cPCX9KkkGRhCy7qRDE6ir25frwDM8m7GJX
         PyDvlV8yHzu5RK5NW8bv8fLNgoXUkz9WQ038rFmyu1N8OQZSZuYN6sj5MMPgmTBPA4Bl
         PfjCI5PseciLZA7y2kU16pgOYaXdeZRzB9yK9cwUIKUfGk+Vcbzt7V2qIHthYUUzuSeG
         8kCnQoWey27lw6Xr4aK4BH2MDMYHUyswqmpNerMo0VToBTQAZPqwOO7y9vfdRPl3viYR
         JABvnC1Y57QubrKXrGKzx4jl+QrbxEz4EU+UhKwmOXY+37cLviFHysiTYZNg8kVXiHiu
         LJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=G+fn4hxgzWTqmz/zDKmy/McB3NVTV4EKthsRD4pVlUQ=;
        b=aUSd6aB5YeoWXx2LXXWTFuNJ6xyMM5xJJDUn6ziF6JAZs47IXV7toRZ9w4AaObTyws
         WVXL3RZawckR/ni5MJH5zdixdj4AgEEK0HyMIErOyl2pCDhr/EPQ/4eZjp1VL4As8i9B
         GZwXDzbNLL5MLVN3LCix258cD/USLEGjMTYKe25qX//zAqmp7K1xPjUGpgeyBZ4/u81k
         rbkqsbieK1rq/MYBR8Q5+VpFEzHv1aYhIMB7pP/ok5EBnkSX09+I/IwGrTML3+ea7PmC
         2WoXcffRBzjMjGd2JC10MXvz3GWofwpSmeNs8iknG+3rWncN3GEygLf8qoB5MUMC5RhW
         Ppew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZoMxmABHkylGaaaVMUeTjJ9B/CTpc6Pk/govpNbiIhdZ+x1fJ5XJKCCFyJQCxube178Qg8/Yw==
Message-ID: <5af1c5fd.1c69fb81.fb7eb.5ee5@mx.google.com>
Date: Tue, 08 May 2018 08:45:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.16.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.16.7-53-g113b01a62036
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
Subject: Re: [PATCH 4.16 00/52] 4.16.8-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599882803803541095?=
X-GMAIL-MSGID: =?utf-8?q?1599911286188648256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.16.y boot: 111 boots: 4 failed, 102 passed with 5 offline=
 (v4.16.7-53-g113b01a62036)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.16.y/kernel/v4.16.7-53-g113b01a62036/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.16.=
y/kernel/v4.16.7-53-g113b01a62036/

Tree: stable-rc
Branch: linux-4.16.y
Git Describe: v4.16.7-53-g113b01a62036
Git Commit: 113b01a62036d61f7ca3d8e6cff988df81700126
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 56 unique boards, 23 SoC families, 15 builds out of 186

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        am335x-boneblack:
            lab-collabora: failing since 3 days (last pass: v4.16.7-330-g42=
715b2b2887 - first fail: v4.16.7-2-g3afbe8ca7a94)
            lab-baylibre-seattle: new failure (last pass: v4.16.7-2-g3afbe8=
ca7a94)

arm64:

    defconfig:
        apq8016-sbc:
            lab-mhart: new failure (last pass: v4.16.7-2-g3afbe8ca7a94)

x86:

    i386_defconfig:
        x86-celeron:
            lab-mhart: new failure (last pass: v4.16.7-2-g3afbe8ca7a94)

Boot Failures Detected:

arm64:

    defconfig
        apq8016-sbc: 1 failed lab

arm:

    multi_v7_defconfig
        am335x-boneblack: 2 failed labs

x86:

    i386_defconfig
        x86-celeron: 1 failed lab

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

---
For more info write to <info@kernelci.org>
