Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526645155; cv=none;
        d=google.com; s=arc-20160816;
        b=lmrj01MPnWxSOULTN1D1/88FGZXef4Gm7MlblfuczcIs+foUcPtUht+tA+GFtdNaAO
         JidDus5O124+LoeLjUhhd7ebyyo7xzgS8lH9nZs2nnyUG1T21B+H8ZNQG92VVD+QAljA
         V+yhQbNifr0rCuOSc8bHFgVE7xv4SBIb3dTPcagBc6W3G+3o40P1yWd7Vmx1YFKYD8cS
         ns+lmcKDAwRUC/bbU7rGO06yNV8fb+gsNCsJPn7tJNo67PUjkSx+bAXORznObO9wH722
         pqw3MG88mNqavQHqiUjSfXE4xHKJYJuvbuK+buXr7THE+kPMFAsadSVjxN4rHhSFninq
         MggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=sID66BzvL7VmWk3I0xs1T6kgHI2r3vUFRJrSMEtwD3c=;
        b=Nk2jPyxcPWYSdt/vCDO1oHdPBq4xeVWINgn+O40VzTNZELhN6TojfCERl1di7e1jEs
         BzZoyBKwbwz5f+1vwwXab/BBrHWTnGNCv/nsKc3wJTVTJzUTlwq8vfrgr63ZgIv2qesV
         6OlXNtbFk4Fz6sFPMj5UK5SCfsBFxIxaBoDJ5/vnspX4DLS/vPxFmGVXebEGxfbBImp5
         G5MYiO15Wj1sSD8Pqx4+1lWNPav6A3Fr8CmHmwAbagrNr2FQw6U6Ot4qDh3f33KvUJt/
         fP+sEbgZUFDAP1aoLS/Upps24QufeQUKijwVqWf9/Hb5MaOoSK/SOGFBROdtwrAnkLvC
         Daow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZoZG6OeHCpz+UFD08DWhtmrIQGAcmw0I6HcvwC5729IPMfzn6hc8GB4zsR5fDlp8Q6GcyjJxQ==
Message-ID: <5afec1a2.1c69fb81.7caf5.979c@mx.google.com>
Date: Fri, 18 May 2018 05:05:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.16.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.16.9-55-g2b695e770deb
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
Subject: Re: [PATCH 4.16 00/55] 4.16.10-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600789089014801693?=
X-GMAIL-MSGID: =?utf-8?q?1600803470069598035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.16.y boot: 111 boots: 0 failed, 106 passed with 5 offline=
 (v4.16.9-55-g2b695e770deb)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.16.y/kernel/v4.16.9-55-g2b695e770deb/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.16.=
y/kernel/v4.16.9-55-g2b695e770deb/

Tree: stable-rc
Branch: linux-4.16.y
Git Describe: v4.16.9-55-g2b695e770deb
Git Commit: 2b695e770debb7122f8c9404f15ad1931815706e
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 57 unique boards, 23 SoC families, 15 builds out of 186

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
