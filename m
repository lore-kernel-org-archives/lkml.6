Return-Path: <jthumshirn@suse.de>
X-Google-Smtp-Source: AH8x225KPTS/lWtSmDOTGCfCHld8P5QtkJ1XPkiaPu3TKCX0563F6/ZTFilit6EvZhHDN5IyB5aE
ARC-Seal: i=1; a=rsa-sha256; t=1519027728; cv=none;
        d=google.com; s=arc-20160816;
        b=tNeQzjXaqpvM4UHh+FWYGT7Qfo95/ZmWrsPGO2ZB13X5A9r5EBfjhaz6eCx77KZJoF
         U1zbfuncbTrBqPuoMTb2uQlxMIhTq6ccFL+mBhSGrPwmZUfXnLtvH7xptiyUha+SF+Rk
         +aAPjSWKHAl83NhP8rfOSth0nkQWXw7s157aZvBxgH3cqeSrM7bRVlm1hxlNhc8ye7Yc
         9/8NtgDpf1hn0urq4tIH0AFzo4SiJUBPlTcaobqRJNOOiDCudV31Q54AD1kHMpnqexFB
         QDfNtfETa+V0o7MoYSzie70kTgJdS3SFEa9sGXyP6gS+tHlTgP422I8FPHpGhfeiIpxU
         COMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=Gqovm+otgNHfFgvfua8MkJA3UzQv5Ceygq5AaC36nJ4=;
        b=pysKpv7euI0WADUwt+DkwlOg4aBPT5028tViILxO+NIsj0JIQPI5gUA41qO8eYp0py
         qrRqvWbWY+jfTJEXAkkmAQYh/TeoKolbuUUXigVlaZPL5atsblxPVuBmbb28qI5UoShP
         xZR3J2WHkDLMUvnsvOLKYbM5ui9zTvDjq4mLw/lWzU4MX2sF/5NomeJZCsqcWpULteSW
         M4H7VBizMh2RFeGd0XkUGLVKXA4SHbDEeBzwfNhXWvQA/Agiygtumjn8YnmpkVjVcn9U
         oUksLJPSjGB2PyedfeF/KuOTcNWcYZCXPADOtKrgq/3s8SuwcoWrvHHN18y+jVKM+MYP
         ZPUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jthumshirn@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jthumshirn@suse.de
Date: Mon, 19 Feb 2018 09:08:46 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	bart.vanassche@wdc.com, axboe@kernel.dk, chris@chris-wilson.co.uk,
	tvrtko.ursulin@intel.com
Subject: Re: [PATCH V2] lib/scatterlist: Add SG_CHAIN and SG_END macros for
 LSB encodings
Message-ID: <20180219080846.xnmyt62lzzqybf75@linux-x5ow.site>
References: <20180215033356.6978-1-khandual@linux.vnet.ibm.com>
 <201802180359.yuetSevh%fengguang.wu@intel.com>
 <c407c32f-a7b6-06c5-4a03-109445e27427@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c407c32f-a7b6-06c5-4a03-109445e27427@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592436393983047782?=
X-GMAIL-MSGID: =?utf-8?q?1592816019176778923?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 09:42:29AM +0530, Anshuman Khandual wrote:
> SG_END is already defined in a driver. Hence shall we change back
> 'SG_END' definition as 'SG_EMARK' or any other suggestions ?

Yes something like this.
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
