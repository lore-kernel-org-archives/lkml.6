Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AIpwx4/y1ESAGcfwbkvS+JgMNuAtD6cKV9VFpQkDGcfVGzvRbDYGgyemxCOc1HZRv+9a+yXmgRKn
ARC-Seal: i=1; a=rsa-sha256; t=1523011904; cv=none;
        d=google.com; s=arc-20160816;
        b=dtN2Mc7SKUEnmCfEWH6eXfJCehLskFrxAsWL4LLnujUHiAZkrVNwo8LeSLFHRlNQHO
         NIv0bpyhgYg4U5VogKUcrK84ls+is4f9Svh2EHZweUlIn1imK6luBJB4Hvzox9bqnhqR
         SAplchZzg8r7ZtvlFtxwM8T7RzuseRebs6X8asdUbXNd1CI6hOkGVmHKDS/r74f3y9rp
         skocFL3s6LTwv93FWyF9oBwl4sgfUtZh7A95iuysUrVzI2uYUxzAm13a0FH57ZaZ27NJ
         bBHOHzSpM+mJJ0Lmhh3r4Wn4k8CgR8sKTYjr6JbkQHI0+0ZMMocR1RuofzUhu48WkQq/
         Lftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Af2gk7w9j3iU8FDWqlSpx2onvO374MwRLhNLGxtCOTI=;
        b=AsBzBBgWdctKC0TKmRUOhwg4T/5KZz7N3WRuIHn3+8h93y5tWIzt8qUouz77zdREsM
         N55ycZ07SRCX2VC/SiHkuOlwpmdO9WVNSVWo21Fh7EoEADTKT+1JGlOCyklucHsw/nBH
         xCNYvt3NBvmTH5MD/P+zHQPBqACHTQTzuN/1WxOdATKoWMz/EjCT9UE8ZuRz1Xo+2xdN
         HhjhI/Ndftirj7FNQQbDrdAhphoeQNJn+Q7VednR3paJ5BBbMvYtxW7YEDIppCgBWG2/
         f3LBhY+Sg1cgm+6DbqEmbu7Q8FcCfy8IBtWVHpWY/ltXBsFRPKLAcOVQKfvi4LuXmxrX
         eDzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,415,1517904000";
   d="scan'208";a="44609424"
Date: Fri, 6 Apr 2018 13:51:39 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Markus Heiser <markus.heiser@darmarit.de>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Masanari Iida <standby24x7@gmail.com>, linux-kernel@vger.kernel.org,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org
Subject: Re: make xmldocs failed with error after 4.17 merge period
Message-ID: <20180406105139.GA28862@kuha.fi.intel.com>
References: <CALLJCT0MFg6b+dG50cqe_hv6hxmQDj-ZM066BOtQt_wOiC8ENA@mail.gmail.com>
 <20180406075109.GA21589@kuha.fi.intel.com>
 <20180406075734.GA16728@kroah.com>
 <20180406081555.GB21589@kuha.fi.intel.com>
 <20180406083010.GA20174@kroah.com>
 <20180406091126.GC21589@kuha.fi.intel.com>
 <2A917B38-AFF6-44DC-A4A9-796B2BE560E2@darmarit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2A917B38-AFF6-44DC-A4A9-796B2BE560E2@darmarit.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596966487828993292?=
X-GMAIL-MSGID: =?utf-8?q?1596993730593532249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Markus,

On Fri, Apr 06, 2018 at 12:03:55PM +0200, Markus Heiser wrote:
> >> There are ways to do this, look at how the v4l2 and I think the drm
> >> subsystems handle ascii art such that "real" drawings end up being
> >> produced.
> > 
> > Thanks. I did not actually find anything else except use of tables and
> > code-blocks in v4l documentation. Is that what you were referring?
> 
> If it is about *figures*: we have a directive named 'kernel-figure',
> which is a full replacement of the 'figure' directive from Sphinx-Doc.
> In addition it supports *inline* SVG and DOT markups. Read:
> 
>  https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#figures-images

Thanks for the info.

I don't want to use for example dot language in kernel documentation.
I want to be able to clearly see the figure also from the plain text
file. That's why I prefer ascii art.

Isn't there a way we could render ascii art as svg diagram?


Br,

-- 
heikki
