Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1527182790; cv=none;
        d=google.com; s=arc-20160816;
        b=mamcEllBWLkGImRR92nMw5cnFxx/U8atk4R8Q4Fc5kTOu4/UBlYdMkOl0fwAttiehx
         BZK92Sh+oN6r2d5+zF6L5SFXO1A9OjEGUUSkW3NoD2/yIur4VDlDjCaI4MI/z5iFiJhX
         UucE7hWIO4PEADQmDS5mWZkeI933BvoC1NkpLizY493ZrOIvjRSForiktOpcfaKmV+cP
         2/7DsmScTatj/2rB3Wzrl3uVixxA0pkyp6pxfjMyaSv1KISvaMILaCayD/QR/PbzhpHT
         W8kj6+/npJyJuyihRedhJ2SbKpfhVfezm3/qglOFc35KDyFf3GIU9OowoLi0+G2ETvVU
         XUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=YG7eE/ly3s0N2NfIYx5VAmnbfPNVzyEDTR5aRDXJ3ss=;
        b=RgMGixeGkn5FyOxt95b++tAxLEf5Nd71U1nv3AMBuDlk6PO/wAVW4Tgpvyb+vjXleY
         Q7LZPbf1MBicqlho5UGo77q0j2MGxAAsKSBTg3sXo7apeodpHFVm7Q4a6YwIFs6O+QsO
         pPPloBTsEnUxcJLdCgynRs5A4ncMGB8bQLVjCaBVXEejO4CSl/wa17faA1dc7ptdYq/t
         eMTmkWnhi0nAgc8nKMX9WOWVi/A+x2zwTVy7kt3ECbnbZmHqqXBLGfVsb1ci99xjmLUG
         joD7z4vxCPPxDQ6AqBC/BUptEhfULZfBPi1hyKKviG7cyGo5QjmJHcdgNiCwAb4b5Gbt
         +oTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZq/JUDD/OUU2II+RjLGlZlQxSw9DTpkgyeSbv+O6aLm6vyGR33PA9J8OIMgkA/2dpCzontspg==
Message-ID: <5b06f5c5.1c69fb81.dbc44.c34b@mx.google.com>
Date: Thu, 24 May 2018 10:26:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.16.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.16.11-162-gec693ff0154a
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
Subject: Re: [PATCH 4.16 000/161] 4.16.12-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601339136054826375?=
X-GMAIL-MSGID: =?utf-8?q?1601367221440761364?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.16.y boot: 116 boots: 0 failed, 111 passed with 5 offline=
 (v4.16.11-162-gec693ff0154a)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.16.y/kernel/v4.16.11-162-gec693ff0154a/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.16.=
y/kernel/v4.16.11-162-gec693ff0154a/

Tree: stable-rc
Branch: linux-4.16.y
Git Describe: v4.16.11-162-gec693ff0154a
Git Commit: ec693ff0154a1ad11520223f3c1d2eb5b13cabf1
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 62 unique boards, 24 SoC families, 14 builds out of 186

Offline Platforms:

arm:

    imx_v6_v7_defconfig:
        imx7s-warp: 1 offline lab

    multi_v7_defconfig:
        imx7s-warp: 1 offline lab

arm64:

    defconfig:
        meson-gxbb-p200: 1 offline lab
        meson-gxl-s905x-khadas-vim: 1 offline lab
        sun50i-a64-pine64-plus: 1 offline lab

---
For more info write to <info@kernelci.org>
