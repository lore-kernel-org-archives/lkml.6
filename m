Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AH8x224+LwMahZmoyjH5kn3m/oRhSADgAXsyBWC1JDAfSAjJbHEcieWZCk/43omu3d//pgQ5OZ/p
ARC-Seal: i=1; a=rsa-sha256; t=1518600553; cv=none;
        d=google.com; s=arc-20160816;
        b=tmxeruMGSIOuHaZBb6yun9oOlkk3sSuZt0RQj4THzSAWhx7E1U5jLMottq7h7Hs5v8
         6PW5d3qSVxdqMTdy+wmcV67jtXXoTGPosDUhDCgXla5sLrUjQjEcVEOztqOz3Il9IMyU
         RnfOVQghpKMxzu0O6GSkjxUEqDswOcl3EzuIELDqonWqf5e2ARSOI8RBdEU6WLysIoO1
         IAj3+m0LNmBoMB6gU7FcY1Yf+VnIAieGEQiI/7S3ObBNHwNygYibwxyHdBCGoH817MWN
         AfmYJxswWK4DDDeea81uX7Hm7jpm33x96/RMikJwTzmUt9WV0y9cCzyppo8QwPVf5jxD
         Oc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=RYxzDRZwtcp6qBovB27obmrm+MkhvSNUGX2aocDhuZg=;
        b=pegurxgT+/GCJgu/rMxy5YmVq5fhXmX/4lI3tqXV8taFTgGJFOmrw2kMpe3dLcwuId
         bjugbShbF3IG4+Qqw7oahwm7mudqHYTHwcbLkfaX5sgR47B+QBrdGdf69qZnIHvRPcJh
         uslmVwg2lF4VdtneXAa6f/FaYQYjGHgxuSDOl3wyQTU6swW6eQFwCf8MRNSRDsvBGRRF
         UEyAQ+jGqR33aAosBcWjq808ewR/fvGbDDgEeTd+RKTOITLhs14vJO01t4/lxuq5fOSD
         PvbOK1qzFhK2//Ang2O6tNzfHJ68hZF4Zd4AmHU5KlnwnLPrZoJcDLpGA4ECCW7KJoU6
         Vn0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v2 0/2] acpi: document sysfs interfaces
Date: Wed, 14 Feb 2018 10:27:24 +0100
Message-ID: <2867905.gflgnk5biQ@aspire.rjw.lan>
In-Reply-To: <cover.1518252138.git.aishpant@gmail.com>
References: <cover.1518252138.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592003615277879108?=
X-GMAIL-MSGID: =?utf-8?q?1592368094425626539?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Saturday, February 10, 2018 9:55:53 AM CET Aishwarya Pant wrote:
> Patchset contains documentation for two acpi drivers- dock and dptf. Description
> was collected from git history and reading through code. This might be useful
> for tracking changes in the ABI.
> 
> Changes in v2:
> - Split up multiple attribute definitions
> 
> Aishwarya Pant (2):
>   acpi/dptf: document sysfs atttributes
>   acpi/dock: document sysfs interface
> 
>  .../ABI/testing/sysfs-devices-platform-dock        | 39 +++++++++++++++++++++
>  Documentation/ABI/testing/sysfs-platform-dptf      | 40 ++++++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-dock
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf

Both patches applied with minor modifications, thanks!
