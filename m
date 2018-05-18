Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526649955; cv=none;
        d=google.com; s=arc-20160816;
        b=IJigYMkSyviQSWVPWLYT9oYJsZKfVa9wYckQFXJxR00uvwkK06JnFqkW2VNQZGffpd
         G36uDM1TloWZLFiHG6zbHQ1cPABWBMKF5x9EzHxn4rUsgojZ+zxXYFwexoYUZ/NBXKMa
         19WfrTZ9lDFcKE05pvnoiQpDDX7XU/ugVW6G2DIWSddms5sjDjT3d+9VxRBSBXYK4lXP
         BUat+XwIS1J0PiwUOcKbILN1grZAJoGiojuA9QlCOwo4tutRfdDJPBuZQErVYIuDx/oB
         FZhI8H6K1kbgLcUJGg9nzTUZpibN3k1jG+3k9LEBlIBbV4I3IeJnXMn/iX++0OqTIask
         DLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=mvFwnFmJqh8oa6DK2CosBzYIWN6KI9UTldOI3Mx5lkM=;
        b=jUN/PsdVZ7j1ahqieID+EzV59VufQcidv1Pjzj25kNWYYTmOzVMPVcgGcaW8Lst+0R
         bqMWld6YF0dTerfsjdNBUZIeAip5kagUqoIbLsC86cUiqIKLxzs22FLOqPseZdTcxiGP
         T4DaK52yhh8M5y3DuyrxPlVVpi4EESS2uK7dp35/A0+494O+eccxNkVqATjyn1ZaQhB8
         mwPsN5d/EGU2ob644RPfyy4wCluF4MD/1WK2uMfRXs3x82u0J5dBkOTQGThcWx/NIkr+
         DmTbeccFLUOq6UYP6rH8IepBze7wTGZx9IbKr7weiZHoOz66XpzcDOZ/uyTnUtjbcXus
         4Ytg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZoZbFXoRlBICO0kRaZRNu+own8tXYovAlrvecnbQepG0qREIBAN1/uRYRsFYanfu2sdiXs2yw==
Message-ID: <5afed462.1c69fb81.649e4.ba64@mx.google.com>
Date: Fri, 18 May 2018 06:25:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.41-46-g879085a4c525
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/45] 4.14.42-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600789259885055441?=
X-GMAIL-MSGID: =?utf-8?q?1600808503380763908?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 113 boots: 0 failed, 108 passed with 5 offline=
 (v4.14.41-46-g879085a4c525)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.41-46-g879085a4c525/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.41-46-g879085a4c525/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.41-46-g879085a4c525
Git Commit: 879085a4c525940c6c3b08d6a2f49fc064bf02a8
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 57 unique boards, 23 SoC families, 14 builds out of 185

Offline Platforms:

arm:

    tegra_defconfig:
        tegra30-beaver: 1 offline lab

    multi_v7_defconfig:
        armada-xp-openblocks-ax3-4: 1 offline lab
        tegra30-beaver: 1 offline lab
        zynq-zc702: 1 offline lab

    mvebu_v7_defconfig:
        armada-xp-openblocks-ax3-4: 1 offline lab

---
For more info write to <info@kernelci.org>
