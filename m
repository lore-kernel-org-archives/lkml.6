Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AG47ELuMy2ETAU63eEV07FgLZ4Hun14vYTpXIcTlYbpxl/f4kMwt2GZHOkeEYHhXTLXhKNjiiXP4
ARC-Seal: i=1; a=rsa-sha256; t=1521645922; cv=none;
        d=google.com; s=arc-20160816;
        b=oV2hzv0TJrg7w+Wni32+AAAq+zj4DaCXH5RiyuyCi49PwZnHxEw/TIBDMd+afxAISz
         DwNtTXILJn92GtA1iOVC2Xhx4pUYq8wvKpYJ7IhARnbiEvrb8InqS8ivx2Gb0EW6m5xr
         st7O2WSnTLmDClbB9L1IwCoN49R2n0dFXviEv96LbmeU8CINP+pk2fQY4TKWskN3GwNP
         QObA8L7LK4QgV0FVGQ0S6uKp20AWrZIO6bx2o4tPfBkur0vYqvElb1bivPT3ZHtnc3/+
         cKceCGC0zwUENYviItGI99GL8ezwRbuFfKM8++fHo8XhigszV9YB9DIh75QodyM1K1iS
         naCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=tYCC4nqW8fSotET/0xIu20TsLTKj6m+yT2tXDNgzyY8=;
        b=ZylxDC8X7y3QP7ynm7i4l/J0jhIyVhhCXxDNGfeSjgpPXfH1J4CXad5VwLfoMOoTd4
         EUQxtsHQ4TwCUttZrMGyfRC5wJsgCScIRgK94ZAYxzIUBZSB6Z8EPaZGJqirGlTNsHnd
         5ZQKUD7pr+QIRYNtM9LvoKXAq6/sS/j6oCamFOkyWOyURnwkPI9QF2cXgs3JauL1cdFe
         phrmo4yQzW8On7gnazEBP3cu4AE4W7lSV+B8P51EMdAhg/8qPzXkXEa56UrtvjOMnAg5
         eMiEZFlIRrguUvCYz0IVJPj6SQDxKvXUraSw6DPggLNL8EU7+6RS4A6rl4Yg5yfBL6tc
         /5hQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Wed, 21 Mar 2018 09:25:20 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Julia
 Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v2] acpi: nfit: document sysfs interface
Message-ID: <20180321092520.43b53f36@lwn.net>
In-Reply-To: <20180223125448.GA16909@mordor.localdomain>
References: <20180223125448.GA16909@mordor.localdomain>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593196408980037383?=
X-GMAIL-MSGID: =?utf-8?q?1595561395460285836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 18:24:48 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> This is an attempt to document the nfit sysfs interface. The
> descriptions have been collected from git commit logs and the ACPI
> specification 6.2.

Applied to the docs tree, thanks.

jon
