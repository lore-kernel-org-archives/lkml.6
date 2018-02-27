Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519707485; cv=none;
        d=google.com; s=arc-20160816;
        b=oNmRVyomLU2jIrngyNNxcuqcVm2cLhyjUg53GT+Oby1T/yx0RBro7foC3QeZHRseL8
         sOPUXL3TWiGE3MWX3SZ3P9PFh/zPn99Q/ouGwgMu2miBZTQsSuohhjizev7O7zSBU2Jj
         l0KDFuU+6DaJe1immSLBFKynU/qO4rO513LtdM5YnCEiQ4kmK2Lf+agXdEQHYY007kJf
         Ps17DkPxHoZdRyX2eFfigGTdOrTxOMnN/qcIek8oS4NbNS+2NYDr2VU5GlpE6X1Ni1O/
         k6uTrrWdxhHzYdntBTWDNzyCb61LEb4hlbnj7u/YdcnO+YKwA91A+somXo5jKk+bO4hC
         SWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=udzJ9cTdl44rdjBUwuSTlo5rZrHb3oRBIl9i+AfhoME=;
        b=ou2zBmlNbfgkCP6M62uWAp8bC1cL6UX2QXzfNx9yW8x7o+k+dd43o5saye9XQkYXhR
         7GJWUQT5yd3txDO4Sfyn9yDmtDunGfMz/TNbv+Iz3UOe2YEUBw90LPo0BM6K7iIJVlOe
         ZLJRQjLNsJHm15OCWWFTt0abbGekAp9Ok0XkHoVcgR1PMCGosuVsoX2arGIZescGIMB1
         8jqpHBKiqS6BTvdk/ebPfWoleZhavC2cWmbpx8v1Ac1o/nQMQC2i7lrfqeZkgbApk1tb
         yEMvXuJcqBk6KIsUKxQMkj+t/Ke+H0eN9nlNl7Ec0zR0lWH7PWsNe2Bg7KR3XZkbWs41
         6kAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x225OYJEvez5VLqwUMjgD5qDbIwF8hH7iT+QYestw7QZkxaZt0lamevkereR1LcBLltuHQxuYkA==
Message-ID: <5a94e55c.0ee51c0a.64f6c.b691@mx.google.com>
Date: Mon, 26 Feb 2018 20:58:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Kernel: v3.18.96-14-g9fdaa6623e85
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180226201527.242286068@linuxfoundation.org>
References: <20180226201527.242286068@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/13] 3.18.97-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593495935920451612?=
X-GMAIL-MSGID: =?utf-8?q?1593528796332662665?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 62 boots: 0 failed, 58 passed with 2 offline, =
2 untried/unknown (v3.18.96-14-g9fdaa6623e85)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.96-14-g9fdaa6623e85/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.96-14-g9fdaa6623e85/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.96-14-g9fdaa6623e85
Git Commit: 9fdaa6623e85034df1bae98e3a543606a0098861
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 30 unique boards, 13 SoC families, 14 builds out of 171

Offline Platforms:

arm:

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

---
For more info write to <info@kernelci.org>
