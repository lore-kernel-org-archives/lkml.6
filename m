Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526964375; cv=none;
        d=google.com; s=arc-20160816;
        b=VW9duOELUD4130Uf1qin3lAmIdd+VnNSUC3RTwwG2dgHYkWbimhluvioU7kYU6soCO
         LV3kPQCnFI7rPqaLRrjacGEtd1x80CGD+TLbr1SYXM15TeZuQ8FqU7QPUmHOqrspLSiO
         2/UuYKl7+xbQbMzN51SO4gIqjZ5315mD89vOTwbe8c5r7v7gXQMjIpouOagT/SO9Dj0M
         TUC+RrtSULm3nCJ3lyL95DRtXpQ1kZA1+ZM6spWzPivLgEOiZb/3t6wD11A75GjDfBer
         loeFvlyhSvygbXgSBKYYHMBvqBBKbj6UZ7BmuLRdqiot2QgvRmgaioe2l1tRLinBs54D
         Aphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=Rtqw70UAss4TSKbehmK2p0qKOvvZFkzAlo1VCDCbg6A=;
        b=bxnS9ia3qkcNNDI700+zgEDBxU+F5scTFBuJtoK4JEWSZ92OcxjmhKezWZ1j88cpA+
         a74pHlkh9Jj6WKdcm0NOKEaNU0qXVI3uq+2pXGMzrBjYZrnBvb9i4unLtxVFtzbAq2Ne
         jp+OfDrDXznshQwBW2Ht7MLDOTNv2gRG6DehW3Y9gK2uU6pm4W69Cebjje0EuAE6PVzg
         ADMpu/BaB/FgD5vr/+5Rir/TXvl1sMkGdWxLtR5gD0PRzjLJvrKcYXFg523un4BD8YHM
         xYvURVA0HxjkPdqt1lMrRmH/C3LOm1K3iu36ZWFsqrBvHCeiTyoWkUHx0HZagPtl9SIj
         gQ4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZq8Y3GnPUSi67iXjbQefwmkj7XQmeZwtmhrdD6Du6SMJi0JrCsmG3440qu3c4nPmr2XKiiMbg==
Message-ID: <5b03a095.1c69fb81.e10d6.6835@mx.google.com>
Date: Mon, 21 May 2018 21:46:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.9.101-88-gc41014362085
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/87] 4.9.102-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601109780215437166?=
X-GMAIL-MSGID: =?utf-8?q?1601138196714901431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 108 boots: 0 failed, 103 passed with 5 offline =
(v4.9.101-88-gc41014362085)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.101-88-gc41014362085/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.101-88-gc41014362085/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.101-88-gc41014362085
Git Commit: c410143620854fe106977e99aec1b73e1bd0a3f5
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 53 unique boards, 22 SoC families, 18 builds out of 183

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
