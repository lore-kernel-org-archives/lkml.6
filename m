Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZrMcJc7S0JiyRyao1e9WEwNsctW90XDqIgw5bmVODC3zx/HWP2VxoZh/wSccWgtMH9+0M/1
ARC-Seal: i=1; a=rsa-sha256; t=1525793065; cv=none;
        d=google.com; s=arc-20160816;
        b=g/mGefUOPMC2d99pPgGu2okWPK2weHwq0sYig6lWnDrOrYp2MJbOdjXOTJr3+Zurp3
         YN6HGD5dhwfaC7PZd0MsXnDnpkfO+1Rd0B2QJNdNl23mMJ/E+UZazejBquFXkpPq/Lcy
         rdhGV7HEQl+fvd1+xAs+/8JnQjcWcqWwv54PdkUKyQHdGj2v3r/tygDvjPseeF7LhAsJ
         C8HLpCgqmJsiZLk9IaD++dOwGKDlLpv1rh7Zrz3z7gN7SNLFDi3UHq+wX+ggBwrNvTO/
         E92+IkC6RwZqPwBn4ZQIBpbSFaDVki5AWJW2Gtdw+ceb1g9bO4zmYt5OnQTcPJakxYDT
         oNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=OUtnfRc7svoIggTtDUF446jOnaISEaMnHvKrqZd3DCM=;
        b=ZdWPPuukfxJWw+7gIRwZ89BhpL5Uv/1E3hVCSAayzz/5OhYecVS/TO60h+i9BPPXjx
         W6FpVBFpu4acsREZtba6GIWMOXMZ0EspLTFdPL4RsW3/mBnBCJAKkWMveAL7LOY0P4HZ
         L8z5VZGq+p4ddgXZ2tGFkl7WGwQqVUmTJUdlKJcQiReryHEA18yo7gBE7lcrZIHkMWVD
         14BhHAQSSabTqm5Pah27jpgGgxo+JIMelOGMU7tzRZ+2zSHPcQDLoMUCBQynV6bOeLE/
         MuFS6K6YHMjmZSgLfpO10nBNDseWBSvvKMcRtOoyMSj3lslgAlstyxFvhf/ocR02yQgK
         iqhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Tue, 8 May 2018 15:24:18 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	keescook@chromium.org, josh@joshtriplett.org, teg@jklm.no,
	wagi@monom.org, hdegoede@redhat.com, andresx7@gmail.com,
	zohar@linux.vnet.ibm.com, kubakici@wp.pl, shuah@kernel.org,
	mfuzzey@parkeon.com, dhowells@redhat.com, pali.rohar@gmail.com,
	tiwai@suse.de, kvalo@codeaurora.org, arend.vanspriel@broadcom.com,
	zajec5@gmail.com, nbroeking@me.com, markivx@codeaurora.org,
	broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
	torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org, jewalt@lgsinnovations.com,
	oneukum@suse.com, cantabile.desu@gmail.com, ast@fb.com,
	hare@suse.com, jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
	khc@pm.waw.pl, davem@davemloft.net, maco@android.com,
	arve@android.com, tkjos@android.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 0/6] firmware_loader: cleanups for v4.18
Message-ID: <20180508152418.GB27853@wotan.suse.de>
References: <20180504174356.13227-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504174356.13227-1-mcgrof@kernel.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599556382367072293?=
X-GMAIL-MSGID: =?utf-8?q?1599909989625404849?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 10:43:49AM -0700, Luis R. Rodriguez wrote:
> Greg,
> 
> I've reviewed the pending patches for the firmware_laoder and as for
> v4.18, the following 3 patches from Andres have been iterated enough
> that they're ready after I made some final minor changes, mostly just
> style fixes and re-arrangements in terms of order. The new API he was
> suggesting to add requires just a bit more review.

We're done with review of the new API for the sync no warn call,
so I'll just re-issue another patch series with those patches
in a new series.

Coming right up.

  Luis
