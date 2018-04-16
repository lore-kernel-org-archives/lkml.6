Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AIpwx48CGPon0mPgqvtib+qsxNk7S4jk3PigAhtZnSHQ0c1kQns+FgfWD1I0jndocd+TBiZ5JhHJ
ARC-Seal: i=1; a=rsa-sha256; t=1523845868; cv=none;
        d=google.com; s=arc-20160816;
        b=swuYC3fQjmUn+ufqO8ML9k67kUSIY40EZJp/IX6bYKu0VUjm07IN4pkRRG6d2OKBhT
         W0+pB0+G5bEFIjy3EC2mo0k0w0btHJwaKLTyGDWoyW/nSRWFfOj41rBk2xosyl3MQpFj
         8APrs4wJ1JcLjYW9WNQbfimR1HT9o4xtZog4/WKVLVzKPHpScXJHh6UP+LmIQO+vzRGE
         K30IMmJXt026Cd700+5JvThl/fvjKfM57bDg+lXxoL/Oy9SxjD9XTrVlZPGsH9V1d/c/
         cAlUJsAVQpWXn9zRobcrUCyHvx9lh6ebjV4dS0xMa/5LK4/DhaWQFHkAhk5ErOQJi+U8
         xttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:arc-authentication-results;
        bh=GdW2iFnlkrr8GcbU5Wq9rwFqoYvbEgVCMy/ARQTtWz4=;
        b=lssERVxQ/ukoVJgxUCXwui+nCDVsK71NRoGwjVsNy3KxT+mwsU35bn0+lv8DSKwvTM
         YO2j6UwA/IlSNi5YoH8FLf2bDtT8akbKfeif+siZZLw60fQb/Dphi3rqDoMgXeISuFsY
         1NgDvySAImeY6L98Af/I9BJcn/eaCZdJOa37NJoxGw0V3EPRhjgFJmAXLrZGcAtNGgBE
         UaHrlArMDaEwTnBcRcFntGCalZvxrzE4f11aNL+FTNAMfVD+e9bexvd7agAiMlkaKkQ1
         E3Pq8IM0JqDrYEukHYoFLjy3tKm57WA90jSUVA0fGTpJ+r3Kmng6ANLw8W5VvBZRC0zU
         X86A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 180.169.121.91 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 180.169.121.91 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: <mpm@selenic.com>, <herbert@gondor.apana.org.au>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>
References: <1523602983-3418-1-git-send-email-davidwang@zhaoxin.com>
In-Reply-To: <1523602983-3418-1-git-send-email-davidwang@zhaoxin.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBod3JuZzogdmlhLXJuZyAtIHN1cHBvcnQgbg==?=
	=?gb2312?B?ZXcgQ2VudGF1ciBDUFU=?=
Date: Mon, 16 Apr 2018 10:30:27 +0800
Message-ID: <000001d3d52a$e1e21830$a5a64890$@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEcNbW5JBf3rz7ghS4vopVB+9xZMaVx6c0w
Content-Language: zh-cn
X-Originating-IP: [10.29.8.18]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1597868205234253043?=
X-GMAIL-MSGID: =?utf-8?q?1597868205234253043?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----=D3=CA=BC=FE=D4=AD=BC=FE-----
> =B7=A2=BC=FE=C8=CB: David Wang [mailto:davidwang@zhaoxin.com]
> =B7=A2=CB=CD=CA=B1=BC=E4: 2018=C4=EA4=D4=C213=C8=D5 15:03
> =CA=D5=BC=FE=C8=CB: mpm@selenic.com; herbert@gondor.apana.org.au; =
arnd@arndb.de;
> grehkg@linuxfoundation.org; linux-kernel@vger.kernel.org;
> linux-crypto@vger.kernel.org
> =B3=AD=CB=CD: brucechang@via-alliance.com; cooperyan@zhaoxin.com;
> qiyuanwang@zhaoxin.com; benjaminpan@viatech.com; lukelin@viacpu.com;
> timguo@zhaoxin.com; David Wang <davidwang@zhaoxin.com>
> =D6=F7=CC=E2: [PATCH] hwrng: via-rng - support new Centaur CPU
>=20
> New Centaur CPU(Family > 6) supprt Random Number Generator, but can't
> support MSR_VIA_RNG. Just like VIA Nano.
>=20
> Signed-off-by: David Wang <davidwang@zhaoxin.com>
> ---
>  drivers/char/hw_random/via-rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/char/hw_random/via-rng.c
> b/drivers/char/hw_random/via-rng.c
> index d1f5bb5..d9448b1 100644
> --- a/drivers/char/hw_random/via-rng.c
> +++ b/drivers/char/hw_random/via-rng.c
> @@ -135,7 +135,7 @@ static int via_rng_init(struct hwrng *rng)
>  	 * is always enabled if CPUID rng_en is set.  There is no
>  	 * RNG configuration like it used to be the case in this
>  	 * register */
> -	if ((c->x86 =3D=3D 6) && (c->x86_model >=3D 0x0f)) {
> +	if (((c->x86 =3D=3D 6) && (c->x86_model >=3D 0x0f))  || (c->x86 > =
6)){
>  		if (!boot_cpu_has(X86_FEATURE_XSTORE_EN)) {
>  			pr_err(PFX "can't enable hardware RNG "
>  				"if XSTORE is not enabled\n");
> --
> 1.9.1
Sorry to write wrong email address of Greg.

---
David
