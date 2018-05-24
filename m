Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1527180388; cv=none;
        d=google.com; s=arc-20160816;
        b=FL2H/XkU9Galk0+oMclZcg2hTs7OSj7glAAuoGEWIEfd8Z9bdSIiZzaiZd1yG9xSKI
         wV0OsQBuPEjGWeT/o/XtGEKdvig7JFwxMir9TIPDv2GcbTzLdGAhyJcsreH2bKs6eD7r
         WawwySuNQWgo0OM9OSiq3LmsYPOgowxmxRmAtADaAXa/zwe7E9edJZ+UIWkWn2woQfNq
         TjtbcySVnhTdfwE9kUaOtv0r0RZ2VHirP/aVYQWZi03mPctelIwn54BNfs/bGsyzLfNg
         BliG31h+lBJfonHjSL7kAqbP1yFjsqUxPZvJXX/XkDTmT2ddLroQnRJrOsTRPyL7q7S6
         TE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=Dkff9dtRhirXie8CYTnSj9cSOmfo/I7z72ycuUhqmA0=;
        b=CzbDtIW4USdEgj3CuQR+EuhCu6o8n9ozPC3De1o+HmjxjYcfDqpGG5ZGBsmT+QWYEZ
         4+VLZcZFvOQD07M2MvWpbk6/GT1ORYgFcHzBdW6rAZuU9mDckMnNueA8PQ209CFDivjL
         17nWAHEDTo55fon9HZOovyCwJGdnmGrtkdWXjfjHxVheA7beWIXk58Nnm2bNNTuoDqp0
         aZuU6F6GzXFl/+45MPxF4WBkij5xqW76DL1hBqEuhSEBTcxrTp8dYEzBqOoXYljaygs3
         a7vT1YRj9KhMyj8iIoYlH4/Ly40zNf5lM3CNiBgkyY0lplOQpjdj6dtqA7o4OtHtgl4T
         Nd2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZpUFI2HZZ7iuBTDFn7wLKVw26G8DQebbTEW7sEHRYzCSVE9JZfrzpP2pVPlz5rkmNoaRgnnOQ==
Message-ID: <5b06ec63.1c69fb81.9fd61.1eec@mx.google.com>
Date: Thu, 24 May 2018 09:46:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.132-93-g915a3d7cdea9
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601338064912967268?=
X-GMAIL-MSGID: =?utf-8?q?1601364703000090586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 95 boots: 1 failed, 93 passed with 1 conflict (=
v4.4.132-93-g915a3d7cdea9)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.132-93-g915a3d7cdea9/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.132-93-g915a3d7cdea9/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.132-93-g915a3d7cdea9
Git Commit: 915a3d7cdea9daa9e9fb6b855f10c1312e6910c4
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 45 unique boards, 21 SoC families, 15 builds out of 178

Boot Regressions Detected:

x86:

    x86_64_defconfig:
        qemu:
            lab-baylibre: failing since 2 days (last pass: v4.4.132-70-gaa7=
ab28e9c5e - first fail: v4.4.132-71-g180635995c36)

Boot Failure Detected:

arm64:

    defconfig
        synquacer-acpi: 1 failed lab

Conflicting Boot Failure Detected: (These likely are not failures as other =
labs are reporting PASS. Needs review.)

x86:

    x86_64_defconfig:
        qemu:
            lab-linaro-lkft: PASS
            lab-mhart: PASS
            lab-collabora: PASS
            lab-baylibre: FAIL

---
For more info write to <info@kernelci.org>
