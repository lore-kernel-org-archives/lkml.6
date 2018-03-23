Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521813660; cv=none;
        d=google.com; s=arc-20160816;
        b=b0kWnISGOR8KQfrb4NukYtpT6Rb2jU+YwKbFpWfx7/aKU0LhJxzVmyVsCEa/NJt7G9
         +RdTo+BwNgCzYij3RdIHGINHVNYvzlptlNEDzJJWLq55l4SYYoLIzqYiVz/JBtU5t4AN
         pq1jiq8TiOxn4eLfePc5YnkdOfbOnal9IP7YVrZp9u36A3no8CFm3arBb2aJD15UxdV3
         MCwpqft0/OcmlzGZuum+PjjZyNKPfljqEgEKRy1a6kt5VYfIhceXBky92GfT+XEUhFom
         KpfmbuGnhHN99SK8vZoWM1SZDb8xRfpugc/9FJGnb5BRebyJmeUuRuIXo26MsmbDRe37
         tg4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=14Zw8MNZ28mkvz5HdJZHVhbi2WzzXK02JCneWKLC1gg=;
        b=VqK2CeedZN7Gm4vLMRiiRgEAJnDuA0lGwy2bUchYhboUJUKQJpN38w3FbJkfY3PWuP
         oZNY5KljpdbAbZ4diqZuPe443/Bky8KOIpNkKUhfliOqjFNFkL89I8HNIgu8LmJYI86x
         3AI2dxR0hRtvslbq47fDFvhJYOfcc1qG/C8f8ok4xoUZymGWZKp57j04+0m/YNN5mWxq
         SSdGM9SXVzyG12sr0Zbn7d9Xe3AyoGSt44Q4xRD1OwQAc3WtZcw0qZFrDNOxtAWsTCmA
         Lx4yaSDUJqVcIVwj15lU2aIPuSEs2Wn5TT4+xO2MN0cRugC5D0e54xNLFG6N78XL24Y2
         sp3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELthFRWlbMEXAQH+12gIgpzMlXluLncXlaI6ALaMF/HRxbVQwK0NFIebIeAaS56P7DiE/xYtag==
Message-ID: <5ab5089b.06d21c0a.4934e.3b14@mx.google.com>
Date: Fri, 23 Mar 2018 07:00:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Kernel: v4.4.123-97-g3054df73e9af
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/97] 4.4.124-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595722980788493728?=
X-GMAIL-MSGID: =?utf-8?q?1595737280599101918?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 95 boots: 1 failed, 88 passed with 4 offline, 2=
 untried/unknown (v4.4.123-97-g3054df73e9af)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.123-97-g3054df73e9af/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.123-97-g3054df73e9af/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.123-97-g3054df73e9af
Git Commit: 3054df73e9afebfd4cd1ee545a4cb8d8022055cc
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 52 unique boards, 20 SoC families, 16 builds out of 178

Boot Regressions Detected:

arm:

    at91_dt_defconfig:
        at91sam9261ek:
            lab-free-electrons: new failure (last pass: v4.4.123)

Boot Failure Detected:

arm:

    at91_dt_defconfig
        at91sam9261ek: 1 failed lab

Offline Platforms:

arm:

    tegra_defconfig:
        tegra20-iris-512: 1 offline lab

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        tegra20-iris-512: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab

---
For more info write to <info@kernelci.org>
