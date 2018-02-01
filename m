Return-Path: <okaratas@yandex.com.tr>
X-Cyrus-Session-Id: sloti22d1t05-238414-1517513272-2-16141529020395690745
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_LOW -0.7,
  RCVD_IN_MSPIKE_H2 -0.001, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='77.88.28.106', Host='forward103p.mail.yandex.net', Country='RU',
  FromHeader='org', MailFrom='tr'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: okaratas@yandex.com.tr
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517513271; b=U3NMo6BKrGobmnDXEWDKdtvwBlHydO0GMW9lO+QDZj1R+At
    AzWDMrAaYwhzvJG+XPVNt9iIlOY6Z+ObTO0sl+kaOQpfrLs5ZD6+dENhU1NTqZmt
    9wpoS5uBgtZWGpDuVGq0ZFhB5bxGNoLT4e2N4IPhGr/dC22SZancSFxRMSRWuEXM
    X9XNbQ5Rh3ygpx3Z3h4BIEBqN6g2UnSAOmX94SWMR7ufjbukloO11oulSXEJJ9hP
    8p2XkJVk92ibIbg7bsLTwBDl/Q0m4eAtbTKA3DSC67P2TuQ/rHyRgqf+x4dXHGVT
    ldO/XabXaBJInr1hpdPvemqP9sDJuibYjpQml4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:in-reply-to:references:subject
    :mime-version:message-id:date:content-transfer-encoding
    :content-type; s=arctest; t=1517513271; bh=yIIo0QC+wV95wZQKIzAzX
    7gBzYZRkNx36onRuWVlJrQ=; b=dVtWkr/q4B5cTsM3AWIZwlvhKFx9Lsw6NY3r7
    vxs2nKaWy6+CXT5HB1HHhbPdPtNDWjEX1ES0YVdckQ4yUIqKg3dQPO+iE5HLTfV/
    0jaNGdGOJEarkN0ngIllMZd7yOYzCKl1ukBU6DsJe4KyzEssjs+pFLHazE4nFkSM
    GwCJucy0NfnAwAsjqXA1nKxx1WKItTENEmI8tKjNU9HCyyYcmI5uqYHgx1kMZ6Fd
    xghWKObRanfeswR5JXOWZ971uWH7wK1JextACdzIqE60da5ebASl5FF+RULQFamW
    RYGmB7/TS5o8UzRqK2XdIpHt/6a8yQSlWBp1jHlxcME19ZZjw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=yandex.com.tr header.i=@yandex.com.tr header.b=TyUE6e0X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,d=none) header.from=zgur.org;
    iprev=pass policy.iprev=77.88.28.106 (forward103p.mail.yandex.net);
    spf=pass smtp.mailfrom=okaratas@yandex.com.tr smtp.helo=forward103p.mail.yandex.net;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=forward103p.mail.yandex.net x-ptr-lookup=forward103p.mail.yandex.net;
    x-return-mx=pass smtp.domain=yandex.com.tr smtp.result=pass smtp_is_org_domain=yes header.domain=zgur.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=yandex.com.tr header.i=@yandex.com.tr header.b=TyUE6e0X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,d=none) header.from=zgur.org;
    iprev=pass policy.iprev=77.88.28.106 (forward103p.mail.yandex.net);
    spf=pass smtp.mailfrom=okaratas@yandex.com.tr smtp.helo=forward103p.mail.yandex.net;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=forward103p.mail.yandex.net x-ptr-lookup=forward103p.mail.yandex.net;
    x-return-mx=pass smtp.domain=yandex.com.tr smtp.result=pass smtp_is_org_domain=yes header.domain=zgur.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mxback15g.mail.yandex.net; dkim=pass header.i=@yandex.com.tr
From: Ozgur <o@zgur.org>
Envelope-From: okaratas@yandex.com.tr
To: Greg KH <greg@kroah.com>,
	Ozan Alpay <ozyalpy@gmail.com>
Cc: "sil2review@lists.osadl.org" <sil2review@lists.osadl.org>,
	"kernelnewbies@kernelnewbies.org" <kernelnewbies@kernelnewbies.org>,
	David Airlie <airlied@linux.ie>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	"llvmlinux@lists.linuxfoundation.org" <llvmlinux@lists.linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
	=?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
In-Reply-To: <20180201180240.GA28042@kroah.com>
References: <alpine.DEB.2.20.1802011823340.4316@alpaca> <20180201180240.GA28042@kroah.com>
Subject: Re: clang warning: implicit conversion in intel_ddi.c:1481
MIME-Version: 1.0
Message-Id: <116291517513264@web58o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Thu, 01 Feb 2018 22:27:44 +0300
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



01.02.2018, 21:03, "Greg KH" <greg@kroah.com>:
> On Thu, Feb 01, 2018 at 06:33:30PM +0100, Ozan Alpay wrote:
>>  Dear Rodrigo Vivi, Ville Syrjälä,
>>
>>  My name is Ozan Alpay, and I am a student mentored by Lukas Bulwahn. We

Hi Ozan,

why did you send e-mail to kernel development e-mail list?

>>  intend to use static analysis tools on the kernel source to identify,
>>  analyze and report issues. As a very first step, we are looking into
>>  clang compiler warnings and will then move to more sophisticated tools.
>>
>>  When compiling Linux 4.15 with clang, we have discovered that your commit
>>  2952cd6fb4cc ("drm/i915: Let's use more enum intel_dpll_id pll_id.")
>>  introduced the following warning:
>>
>>  drivers/gpu/drm/i915/intel_ddi.c:1481:30: warning: implicit conversion from enumeration type 'enum port' to different enumeration type 'enum intel_dpll_id' [-Wenum-conversion]
>>          enum intel_dpll_id pll_id = port;
>>
>>  To reproduce it, you can compile Linux 4.15 with clang with this command:
>>
>>  make HOSTCC=clang-5.0 defconfig && make -j32 HOSTCC=clang-5.0 CC=clang-5.0
>>
>>  If you don't have clang installed in your system, you can use this simple
>>  docker setup to compile the kernel with clang:
>>
>>  wget https://raw.githubusercontent.com/bulwahn/linux-kernel-analysis/master/docker/kernel-clang/Dockerfile && \
>>  docker build -t kernel-clang . && \
>>  docker run -v <your kernel source directory>:/linux/ kernel-clang /bin/sh -c "cd linux && make CC=clang-5.0 clean && make HOSTCC=clang-5.0 defconfig && make -j32 HOSTCC=clang-5.0 CC=clang-5.0"
>>
>>  While we were doing our analysis on 4.15, we noticed that you already
>>  resolved this warning on linux-next with your work in commit bb911536f07e
>>  ("drm/i915: Eliminate pll->state usage from bxt_calc_pll_link()"). So,
>>  since it is resolved on linux-next and we expect that this commit will be
>>  merged in the merge window for 4.16, there is probably nothing further to
>>  do.
>>
>>  Linux 4.15 is shipped with this clang warning, but we don't see the
>>  crucial need to provide a backport commit to the stable branch for 4.15.
>>  We just wanted to inform you about our analysis of this clang warning.
>>  Ultimately the final call if you would like to address this clang warning
>>  in 4.15 is yours.
>
> Note, I have not taken "clang warning fixes" for stable kernel updates
> in the past, and I doubt I will in the future, unless the tree "builds
> clean" with clang. If it eventually gets there, then yes, I will do
> that.
>
> Note, if you are going to email this out to everyone who fixes a warning
> message, you might want to reconsider it. That's going to be a lot of
> work, and for people who have already fixed an issue, it's kind of
> pointless to just remind them of work they have done in the past, right?
>
> What is the goal of these types of emails?
>
> thanks,
>
> greg k-h

Ozgur
