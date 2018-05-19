Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbeESMZH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 08:25:07 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:46283 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbeESMZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 08:25:03 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DlAAAPFwBb/4gNJK1dGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNDYX0oCoNqiASMeYMIkzaBeAsjhEkCGoF3ITQYAQIBAQE?=
 =?us-ascii?q?BAQECbBwMhSkGIxFFEAIBCBoCJgICAjAVEAIEDgUIgxyBfw+pcoIciEqCCgW?=
 =?us-ascii?q?BCYcsgVQ/hBuDEQOBPwEBgx6CVAKYTAkCjk2BMQGLUyuQJQIREwGBJAEcOIF?=
 =?us-ascii?q?ScBWCfoJIgzSKUm8BAQGNboEfgRgBAQ?=
X-IronPort-AV: E=Sophos;i="5.49,419,1520899200";
   d="scan'208";a="116881795"
From: "Jon Rosen (jrosen)" <jrosen@cisco.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
        David Windsor <dwindsor@gmail.com>,
        "Rosen, Rami" <rami.rosen@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Mike Maloney" <maloney@google.com>,
        Benjamin Poirier <bpoirier@suse.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] packet: mark ring entry as in-use inside spin_lock to
 prevent RX ring overrun
Thread-Topic: [RFC PATCH] packet: mark ring entry as in-use inside spin_lock
 to prevent RX ring overrun
Thread-Index: AQHTy5aFtVi5IJ8ejEig7CpBQEL4WqPw40yA///J04CAALsRgP//wqYggEYWbOA=
Date: Sat, 19 May 2018 12:25:01 +0000
Message-ID: <2892dba45c4e432f8fdea30e20a9faa5@XCH-RTP-016.cisco.com>
References: <20180403215526.15934-1-jrosen@cisco.com>
 <CAF=yD-L8DaS7LW4SAaTRd2RPxVnfrdiVLCdWJxxaTu3Hn8ORSA@mail.gmail.com>
 <057239cdf1c34bc69636009c9e099214@XCH-RTP-016.cisco.com>
 <CAF=yD-LP7RjenkfbFq+dG9XFZx2D7-JwqOeVD+1tLjgXxh8SpA@mail.gmail.com>
 <dcd34772073547818c3e1e5d0b4cfaf0@XCH-RTP-016.cisco.com>
In-Reply-To: <dcd34772073547818c3e1e5d0b4cfaf0@XCH-RTP-016.cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.117.112.181]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4JCPB6L019366

Forward link to a new proposed patch at:
https://www.mail-archive.com/netdev@vger.kernel.org/msg236629.html
