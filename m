Return-Path: <palmer@sifive.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522887288; cv=none;
        d=google.com; s=arc-20160816;
        b=TdeBu18oJJzXQmXbdzT+hUv1dV5KhbG71tlmnBr64favdiH5SZVm6KFclhg0a2OzAi
         ImNl0iIaB9RzbMwKXsG0fHLJ1p4pDuPCgVhOlB4+AZ+CYTlqQNIdILRDGEkbLl+/bT1K
         cxsqI210Pb8Ie5iIyQpRP7/OkymD2KhrSra8y1P0D6bYF76BLJwI/jswMO9/VRWE9Rlp
         j8y7X3OuB7ItorBehKmIDwpa8TCNSu8Nkb82LK43+AKlIg8H4LDLdrtCqc77wzmKY961
         3znTkYLyls4oRWicq6YSsVci2eqdo3chFIYMgTKnHhrnFV3ayQO1P8Rs93t9vL0Nlafr
         sQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:dkim-signature:arc-authentication-results;
        bh=mfi1Nbnv+To2+vsQQf8T3KagcLUnhnxqJ7evTv6Z/Jk=;
        b=fmbjCmDo+DXRiKYIoTpyu3xuWg6dryMtcPCWyFz7DZQ51htD4NxvZ4Ks780GrLLgec
         exDfGFgd082BkHDFc86sOtZYp3WCgQ7o7eoVEziCm4i+4dcogTXbTz5Ap8SHc8DRxoi2
         ZiUOWogxWqbl7XIGR9/KYYb+g2bvwqIUtQLxks81Qjihqq0QhiOuSLlIReckupPDCZQJ
         DgDZgxzk46QNmPs1761we/lTvir/5w3IsKL60eytE/12XY4eZ1ijQFHqWdDXpvT4jobl
         e9BQXCF9/fzoFFPKELsx6k4/7nAuU1PxtNHXyf3JEBvWZtmyNrBDoCep96kGUtdEM4ef
         W6DA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sifive.com header.s=google header.b=RzCMwahT;
       spf=pass (google.com: domain of palmer@sifive.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=palmer@sifive.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sifive.com header.s=google header.b=RzCMwahT;
       spf=pass (google.com: domain of palmer@sifive.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=palmer@sifive.com
X-Google-Smtp-Source: AIpwx48ilORCOzWnd+xrbgAl5Z+1nZwEAFnyNNk2OdE2vKAFjrJ3ngAcvqfeQGpgFntLvOqBDLF2BA==
Date: Wed, 04 Apr 2018 17:14:46 -0700 (PDT)
X-Google-Original-Date: Wed, 04 Apr 2018 17:12:22 PDT (-0700)
Subject: Re: [PATCH v5 2/3] lib: Rename compiler intrinsic selects to GENERIC_LIB_*
In-Reply-To: <20180404220258.GA9347@saruman>
CC: matt.redfearn@mips.com, antonynpavlov@gmail.com, ralf@linux-mips.org,
  linux-mips@linux-mips.org, mcgrof@kernel.org, robin.murphy@arm.com, geert@linux-m68k.org,
  linux-riscv@lists.infradead.org, clm@fb.com, ynorov@caviumnetworks.com, jk@ozlabs.org, f.fainelli@gmail.com,
  Greg KH <gregkh@linuxfoundation.org>, akpm@linux-foundation.org, bart.vanassche@wdc.com, robh@kernel.org,
  terrelln@fb.com, dan.j.williams@intel.com, albert@sifive.com, viro@zeniv.linux.org.uk,
  tom@quantonium.net, linux-kernel@vger.kernel.org, richard@nod.at, paulmck@linux.vnet.ibm.com
From: Palmer Dabbelt <palmer@sifive.com>
To: jhogan@kernel.org
Message-ID: <mhng-80bc3ae8-ec63-4482-ad4e-1dddec475753@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596716596411217880?=
X-GMAIL-MSGID: =?utf-8?q?1596863061217123936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 04 Apr 2018 15:02:58 PDT (-0700), jhogan@kernel.org wrote:
> On Tue, Apr 03, 2018 at 03:39:34PM -0700, Palmer Dabbelt wrote:
>> Sorry, I'm not sure if this is the right patch -- someone suggested acking 
>> this, but it's already Review-By me and if I understand correctly it's going 
>> through your tree.  I'm a bit new to this, but if it helps then here's a
>> 
>> Acked-By: Palmer Dabbelt <palmer@sifive.com>
>
> Thanks Palmer.
>
> No worries. FYI Documentation/process/submitting-patches.rst appears to
> now contain lots of gory detail about what Acked-by and Reviewed-by are
> supposed to mean.
>
> In this case an acked-by is needed to show your approval of the parts of
> the patch which touch the subsystem you are responsible for (and/or code
> which you have authored) so that the patch can go via another tree. It
> usually indicates that you've reviewed those parts of the patch too, but
> not necessarily the whole thing.

Thanks!
