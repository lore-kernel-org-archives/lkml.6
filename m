Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AIpwx4/SQA+jQD+OJRYU7WcoGr/SNOEwkTpReq9D1QOcjXLzustdf7yZALtO2jztKYUaUngun7rp
ARC-Seal: i=1; a=rsa-sha256; t=1521899750; cv=none;
        d=google.com; s=arc-20160816;
        b=0tk/xsfWNxh+9TTnmG6iV73ByMphsb0aSANYAJrWJLPEgO7KoSRBKVUD2m2hPdINVb
         dxmHUEWNks7z/jrVKcJQ3Rfc44TBn+8MvXBO5e8PI5nK+aET2MyyDTfI0gjp3aMrdcll
         uOAvQiFJ4/FgI+xpgJ1+jWBDSnmqIHgrSydWqCyWCvdpP+kefTAULmxg9oIti/DePXZg
         l6aIt/RNija3eBLwpw217QaDH5lZSHW+OkQ9LZmNU/bveuvJpMop+Ate+719uL+9Wutl
         C2VePZUr70x/ohXjrFpOqKhJx3PvShzmmTeSSOJHzY/tBtXkONX0KLrCzGV1cF5+p6O0
         hlIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:arc-authentication-results;
        bh=+Ck+Zj44JLdeOlFAKf+h32fRL+gxHqwNfnG4lL3+BwY=;
        b=YEtzPRzPjwZ55fL52+fpgyGzbDbl5nNLmPGVnZdtWrOElBQCdAS8btQ6bzDn7qQ6gH
         0/S87I0lh+3FVJlt2DGsVs4styP9vc4SyckTxwuAru0iTPgiW5Oxs+KDLIpLKffncorK
         YJqfNQ0UwpMqz4Icf3vRLURrDFOjL9IRCPINYMLUQlawbMaYGHmAvypm8kz69CIxQEht
         Crpeu7s1ScF2n5xfzy6Y912O8KVawndPAtX0YKhjhZAVreQ7tvC9AOrq5XXLjHWDVA03
         ItQAscV8SQOaUBPTh5BlC2kxoJUKtH9tX+dgCrK7YXwhY6wb/uy1pAfLFlt40gUObY/E
         AgSA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.255 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.255 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com>
To: kbuild test robot <lkp@intel.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>, "kstewart@linuxfoundation.org"
	<kstewart@linuxfoundation.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"afzal.mohd.ma@gmail.com" <afzal.mohd.ma@gmail.com>,
	"alexander.levin@verizon.com" <alexander.levin@verizon.com>,
	"glider@google.com" <glider@google.com>, "dvyukov@google.com"
	<dvyukov@google.com>, "christoffer.dall@linaro.org"
	<christoffer.dall@linaro.org>, "linux@rasmusvillemoes.dk"
	<linux@rasmusvillemoes.dk>, "mawilcox@microsoft.com"
	<mawilcox@microsoft.com>, "pombredanne@nexb.com" <pombredanne@nexb.com>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
	"nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "thgarnie@google.com" <thgarnie@google.com>,
	"dhowells@redhat.com" <dhowells@redhat.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>, "tixy@linaro.org"
	<tixy@linaro.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "zhichao.huang@linaro.org"
	<zhichao.huang@linaro.org>, "jinb.park7@gmail.com" <jinb.park7@gmail.com>,
	"labbott@redhat.com" <labbott@redhat.com>, "philip@cog.systems"
	<philip@cog.systems>, "grygorii.strashko@linaro.org"
	<grygorii.strashko@linaro.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "opendmb@gmail.com" <opendmb@gmail.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "kvmarm@lists.cs.columbia.edu"
	<kvmarm@lists.cs.columbia.edu>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 7/7] Enable KASan for arm
Thread-Topic: [PATCH 7/7] Enable KASan for arm
Thread-Index: AdPDdfIYGLcv82BJRHWzogVD6g2xLw==
Date: Sat, 24 Mar 2018 13:55:37 +0000
Message-ID: <B8AC3E80E903784988AB3003E3E97330C007750D@dggemm510-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.90.243]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281352954780373?=
X-GMAIL-MSGID: =?utf-8?q?1595827553562147066?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/20/2018 2:30 AM, kbuild test robot wrote:
>All errors (new ones prefixed by >>):
>
>   arch/arm/kernel/entry-common.S: Assembler messages:
>>> arch/arm/kernel/entry-common.S:85: Error: invalid constant (ffffffffb6e=
00000) after fixup

I'm sorry!
We need to add the fellowing code to solve the upper error:
> git diff
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.=
S
index b7d0c6c..9b728c5 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -82,7 +82,8 @@ ret_fast_syscall:
        str     r0, [sp, #S_R0 + S_OFF]!        @ save returned r0
        disable_irq_notrace                     @ disable interrupts
        ldr     r2, [tsk, #TI_ADDR_LIMIT]
-	cmp     r2, #TASK_SIZE
+	ldr		r1, =3DTASK_SIZE
+	cmp		r2, r1
        blne    addr_limit_check_failed
        ldr     r1, [tsk, #TI_FLAGS]            @ re-check for syscall trac=
ing
        tst     r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
