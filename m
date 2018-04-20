Return-Path: <jani.nikula@intel.com>
X-Google-Smtp-Source: AIpwx4/PRTAYwHZThFOdGCEzAOnbiBwoJCxu8PzZkhABXyLkwhU6No8EQYZfmzS4BM+XIsNHZCkF
ARC-Seal: i=1; a=rsa-sha256; t=1524210479; cv=none;
        d=google.com; s=arc-20160816;
        b=UEtnQ9EXIM1D0A12H0OEznV3nuDeejNXIcEaCkkiAJux8OKS26jGKdZhSQhKXdD3Ys
         Frbnz0kdAo7K7oVLqQRFZemC9S5xcVNyOtiotew1pExDryjbcnvYI4I18g/YUW7WIL7A
         Xcs9UtRF0LnoUskTIw0h9QD+A4giLq05dNV8GUP+ZFYd1puFR1pTofEKW641YBTR8uMU
         oqHrDuSrEPeGkSd9dUQ/Hz+Yu9JbZUqTr1C55UDgLD7Ivlzq9ZfTF+fWo6F7JQbXS/NS
         kglWmv/ExmsePzaqDW7eSV6QEOyOxWxcSAxi+y9mZKhfEpYlZYBzVM5slgZBdVFrXcwG
         5L7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:organization:in-reply-to
         :subject:cc:to:from:arc-authentication-results;
        bh=yYFczIfVTgmuS2dN3dmlzhyGg37zbXEAr+FftETTWjk=;
        b=S1+4B6k1t1MKlyW5e3UCZyZp19m34lWuqU0EZTzg8e/jTFH3JS+H2VkL2TW6tcrkgD
         OBJfKqVb4I8U8pRktXj4+nk4ZRcltPzCzBSWhA5j02pzcaCvxWJ/+mDkC2excWLdbzu3
         3JhBASvUpbsQHyLVTgNwBCfNfYBIvD0a9ZD/CtQmyTDxjzp9C+z83u9SoHsa9z0DpSCV
         USqopDGGp0W7oaxxVzOieYqujnFDVsDzvle0QIbGmzGm39xb7bAyqjwZ7Rtf7posZe+f
         B2fzUEDh2VbKndbwisjTTZdQTeXkcUL+Az7RStRHknpcjyF5g8Avt1+678/7s2+dPzJe
         kBgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jani.nikula@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jani.nikula@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jani.nikula@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jani.nikula@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,300,1520924400";
   d="scan'208";a="48477947"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ian W MORRISON <ianwmorrison@gmail.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: "Srivatsa\, Anusha" <anusha.srivatsa@intel.com>, "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>, "Wajdeczko\, Michal" <Michal.Wajdeczko@intel.com>, Greg KH <gregkh@linuxfoundation.org>, "airlied\@linux.ie" <airlied@linux.ie>, "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable\@vger.kernel.org" <stable@vger.kernel.org>, "intel-gfx\@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for Geminilake
In-Reply-To: <CAFXWsS8o72qgO419muew4ei3VgorYWmGq0k=xPNe1es3DmD0gw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180411044213.383-1-ianwmorrison@gmail.com> <871sfmhz88.fsf@intel.com> <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com> <87lgdugc85.fsf@intel.com> <83F5C7385F545743AD4FB2A62F75B073338FD128@ORSMSX108.amr.corp.intel.com> <87r2nefbnn.fsf@intel.com> <152397448099.13647.3490065625139821046@jlahtine-desk.ger.corp.intel.com> <CAFXWsS8o72qgO419muew4ei3VgorYWmGq0k=xPNe1es3DmD0gw@mail.gmail.com>
Date: Fri, 20 Apr 2018 10:50:40 +0300
Message-ID: <87o9iee2pb.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597423482826443546?=
X-GMAIL-MSGID: =?utf-8?q?1598250527838023019?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 20 Apr 2018, Ian W MORRISON <ianwmorrison@gmail.com> wrote:
> I've performed backport testing and some additional analysis as follows:

What testing did you do beyond booting? Did you run igt?

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center
