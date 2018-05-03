Return-Path: <morten.rasmussen@arm.com>
X-Google-Smtp-Source: AB8JxZp9KOsLjzzF8B/oekiE7VRpiZR1J9qOjoMNBHtJF+9uGZvLe2Vkca58PaAAJn85G948ZZtm
ARC-Seal: i=1; a=rsa-sha256; t=1525360458; cv=none;
        d=google.com; s=arc-20160816;
        b=PD4CXNhiuEuWxXRM8l8ORZQCkOUhVI4E1mCTB1RuXpwDvrqbZYE6dYmsLnRlgCJsq+
         mFe4q3PvVXpw19taZyxn+Mj2IB66nK+N2RqLrhqTcrmFdtzsZvzHOV5WGC5zXHD/qsdY
         c7xYo74I51EDu1Wjo9+cc6cc5gGtP3XAaJ6EoB8gN3a41Bt9Zd6gNYdMKi9/XZgPe++3
         fYq9G5fJaxfvRgCFEMSr+hDI5dXlRbz3AUATsOOYi8Yox0BKsvlpGPPZpRDTLEXpVsRJ
         JmyW0KQmTPFJ+0AaWdyvOczVLnK6Rthdi9/ZrhLd+bWsBsvjhH+9GfWagGe2q7SBEzru
         B3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=kjWjEyhhJx4Zi7SjhkBN6OSmuaZaHU2nvDSMHRT6E64=;
        b=pexSq34BUV8xzmSB4ispNSHZZ0TvvEmAetyU1HWRRJj+klShvYvxsNlzV/ANluWITP
         kGTnS82nX9mzPYB1tC2SO8aqwLGaONPEgy7OsegPI80BksiHIypBvCK88lWWzZaMuTFj
         Ak5Mg5qBNzt9DwHCqMZL0JrVttIDZjONrguz6+Fv9+Ia3OaedD/rseqBjRlP18Pl/CmP
         gw4LUjuN7V1w1bs++s82pRbZtbMMXYgCSPongvFW2wjHaR8rOqhBkMEl/NZz9Lzh2eKv
         2R/qUys/RPPWWv8cah+lCdRTHaS+Fvwm6VT+wWsckcVy0Yj4R60l+kua+NgrUvYNyRih
         rzdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Date: Thu, 3 May 2018 16:14:12 +0100
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, Sudeep.Holla@arm.com,
	linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com,
	hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com,
	Catalin.Marinas@arm.com, gregkh@linuxfoundation.org,
	Mark.Rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org, ahs3@redhat.com, Dietmar.Eggemann@arm.com,
	palmer@sifive.com, lenb@kernel.org, john.garry@huawei.com,
	austinwc@codeaurora.org, tnowicki@caviumnetworks.com,
	jhugo@qti.qualcomm.com, timur@qti.qualcomm.com,
	ard.biesheuvel@linaro.org
Subject: Re: [PATCH v8 10/13] arm64: topology: rename cluster_id
Message-ID: <20180503151412.GC28409@work-enc>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-11-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425233121.13270-11-jeremy.linton@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766326590040185?=
X-GMAIL-MSGID: =?utf-8?q?1599456368231650171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 06:31:18PM -0500, Jeremy Linton wrote:
> Lets match the name of the arm64 topology field
> to the kernel macro that uses it.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Acked-by: Morten Rasmussen <morten.rasmussen@arm.com>
