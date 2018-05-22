Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526955991; cv=none;
        d=google.com; s=arc-20160816;
        b=iqQZDrgDS8FMlSfXderGcJCG7GPbP9eAs4xGd7A3aeUgTsMlC7/Feuw3Vhj79m2FQo
         4TBvivYU1PDdY8PVcj76dJCZvfosSk/odRBnOxUMSOUCyJ3Sj4PqNdNjikCQ5uZSOK/i
         Shk3BdrfISPRbrD9LNVnhBsOeEnjp/8zLHr7ZrVfdLXetCYjHeqOhp6HbyJJ+5TqbWJW
         YLYuApgLHascekLCqusmb4w0x3TMIMHnkGXjynQqtvnTx5+WT2ycvf7l0mjLJTlp7Xkm
         SasW9b2g2sBTBuSxzu9xtz8Lws2P1rZruuxwnrKrakUQuua+PgyyM7IBiJEAd5fXaO8B
         21+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=cTNbwT/sTaX7pZG9KTV8FPwIhBi4emD2khHx0nU8JhA=;
        b=bWXpjFZg5JTR7/4OOk3yZ5REkbo9cVaxKbquqptY9bysIWfWu8MZwwIlDCgtwsZdm+
         B+Iu35vzx/ghreJ8QkRwtuDPBNNr5WXTYvGJ0ZFT6cJdQrpd3MWR7hDDA7GaFzPC/dha
         //YvczGHwZto+MtkTv+6uYheUW6qWoH+Pqb3IEBAyNPVTMJxVfNfbiUIrKx0ypQWmLut
         XMWR3zSU5weCF2gY1NvMENUmvcgrRLVzWDRrLEzp8u52fzXR7cDK4RlTYtnnSOKyGn9w
         cgJOdDCVJpGhpSb0yLbxuDBkYtPloDIjVLX+08h30FNFxfRV+zBubszHAUN02ISpBwfZ
         bqjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZqDru0KubWp4n+VBWiH5jwOXUDHqpVEXqyR4K9zyGtS4UaFg5dG38lDRQtt2sSFiwZIeMNHLw==
Message-ID: <5b037fd6.1c69fb81.7ef92.a485@mx.google.com>
Date: Mon, 21 May 2018 19:26:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.14.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.14.42-96-gb98076ba9976
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
Subject: Re: [PATCH 4.14 00/95] 4.14.43-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601110078992471569?=
X-GMAIL-MSGID: =?utf-8?q?1601129405145694030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.14.y boot: 116 boots: 0 failed, 111 passed with 5 offline=
 (v4.14.42-96-gb98076ba9976)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.14.y/kernel/v4.14.42-96-gb98076ba9976/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.=
y/kernel/v4.14.42-96-gb98076ba9976/

Tree: stable-rc
Branch: linux-4.14.y
Git Describe: v4.14.42-96-gb98076ba9976
Git Commit: b98076ba9976b9ea99d2595ee3af9f94a0c0d22c
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 60 unique boards, 23 SoC families, 15 builds out of 185

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
