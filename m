Return-Path: <kernel-hardening-return-12943-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+P1Yv2mFDAV92d6hlukm9kpEjqUlGzz++c+u0kUEsD2P0xfNYzsUdLvaDogxr5Bf+vCUM5
ARC-Seal: i=1; a=rsa-sha256; t=1523315683; cv=none;
        d=google.com; s=arc-20160816;
        b=H7Agge578B/cFT0EN8/FDZ0oYSREZLJQf/1mJ+8zPyevGazR66e3NFGnKCZOQfw9n6
         PCrbYjTSuTvSJB7hkMtBWU3620S8NwR2yb1wuA+W/gxDQej4ndNH4l9+ptrLczoHSgso
         KiUiu+c6Qzla2OqVwCJluJRN2p5r1Xy14A1DX+ismshquNrIhdu9yDm1lEQtC8kmkt0C
         PZ04SSYq/PgPtmtbfWk6UeuFyY4uctBoZVTmeF9V12c2b/fWmiNfaSJSkTZH73qtTb3d
         aGzJwqvapd/++KUBpOOu9FNX9+AcHS0BCdSWSStwNH8pgog9TtJOc6VVv0Ddp8abMG3j
         qZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-id:mime-version:user-agent:message-id:subject:cc:to:from
         :date:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=6m44sjnBeOmnynjQV7x5NIuIbXaMV/5ywIw5H8vuZCo=;
        b=BZmp8YnE2cFARZEJBpir6NBk9Pdpx7icmzNI3dhbQcRNte/ocMNpQsSaU0/9RFfA3q
         8GWTcHzgyrxiBQENf+AmUQaMoCdw02X4RW0FiQoNgBnipNGFBJpGschW4maPkNd0OXU1
         OdYqmATvcJJB8TdSF8jgSJRm4mP/Gm1RRyoMOjbWtnb6dzh2CDsBlVpeJ5UEpIoEDbJy
         qcmEp4jRDHwYU9DP7WARATVB238jjqFN9+jwAdH//kYbtakYwbfVpo79J1mzvsd7v9Ku
         E0Rp0KT7ZWRE4aL8TJjsRJeiHTVtd4jPr6pXldvjnitznVJ0jKhNgb2VW2xd7HBNWO9A
         lm5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12943-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12943-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12943-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12943-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 10 Apr 2018 09:14:19 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
cc: lwn@lwn.net, fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov,
        Linux Security Summit Program Committee <lss-pc@lists.linuxfoundation.org>,
        linux-crypto@vger.kernel.org, Audit-ML <linux-audit@redhat.com>,
        gentoo-hardened@gentoo.org, keyrings@linux-nfs.org,
        tpmdd-devel@lists.sourceforge.net, kernel-hardening@lists.openwall.com
Subject: [ANNOUNCE] Linux Security Summit North America 2018 - CFP
Message-ID: <alpine.LRH.2.21.1804100911160.11121@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1665246916-1034505349-1523315591=:11121"
Content-ID: <alpine.LRH.2.21.1804100913240.11121@namei.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597312265492144483?=
X-GMAIL-MSGID: =?utf-8?q?1597312265492144483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1034505349-1523315591=:11121
Content-Type: text/plain; CHARSET=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LRH.2.21.1804100913241.11121@namei.org>

==============================================================================
		   ANNOUNCEMENT AND CALL FOR PARTICIPATION

		   LINUX SECURITY SUMMIT NORTH AMERICA 2018
                             
			         27-28 August
			       VANCOUVER, CANADA
==============================================================================


DESCRIPTION

  The Linux Security Summit (LSS) is a technical forum for collaboration
  between Linux developers, researchers, and end users. Its primary aim is to
  foster community efforts in analyzing and solving Linux security challenges.

  LSS will be held this year as two separate events, one in North America
  (LSS-NA), and one in Europe (LSS-EU), to facilitate broader participation in
  Linux Security development. Note that this CFP is for LSS-NA; a separate CFP
  will be announced for LSS-EU in May. We encourage everyone to attend both
  events.

  The program committee currently seeks proposals for:

    * Refereed Presentations:
      45 minutes in length.

    * Panel Discussion Topics:
      45 minutes in length.

    * Short Topics:
      30 minutes in total, including at least 10 minutes discussion.

    * BoF Sessions.

  Topic areas include, but are not limited to:

    * Kernel self-protection
    * Access control
    * Cryptography and key management
    * Integrity control
    * Hardware Security
    * Iot and embedded security
    * Virtualization and containers
    * System-specific system hardening
    * Case studies
    * Security tools
    * Security UX
    * Emerging technologies, threats & techniques 

  Proposals should be submitted via:
    https://events.linuxfoundation.org/events/linux-security-summit-north-america-2018/program/cfp/


DATES

  * CFP Close: June 3, 2018
  * CFP Notifications: June 11, 2018
  * Schedule Announced: June 25, 2018
  * Event: August 27-28, 2018


WHO SHOULD ATTEND

  We're seeking a diverse range of attendees, and welcome participation by
  people involved in Linux security development, operations, and research.

  The LSS is a unique global event which provides the opportunity to present
  and discuss your work or research with key Linux security community members
  and maintainers. It¢s also useful for those who wish to keep up with the
  latest in Linux security development, and to provide input to the
  development process.


WEB SITE

  https://events.linuxfoundation.org/events/linux-security-summit-north-america-2018/


TWITTER

  For event updates and announcements, follow:

    https://twitter.com/LinuxSecSummit
  

PROGRAM COMMITTEE

  The program committee for LSS 2018 is:

    * James Morris, Microsoft
    * Serge Hallyn, Cisco
    * Paul Moore, Red Hat
    * Stephen Smalley, NSA
    * Elena Reshetova, Intel
    * John Johansen, Canonical
    * Kees Cook, Google
    * Casey Schaufler, Intel
    * Mimi Zohar, IBM
    * David A. Wheeler, Institute for Defense Analyses

  The program committee may be contacted as a group via email:
    lss-pc () lists.linuxfoundation.org

--1665246916-1034505349-1523315591=:11121--
