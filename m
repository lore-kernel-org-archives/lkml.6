Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935127AbeEIO0r convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:26:47 -0400
Received: from smtp-out6.electric.net ([192.162.217.184]:56772 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934617AbeEIO0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:26:46 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'damian'" <damian.tometzki@icloud.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel build with gcc 8 a lot of warnings
Thread-Topic: Kernel build with gcc 8 a lot of warnings
Thread-Index: AQHT5KvOC7Ric82NSE+D7PGPhsS2jaQnei0Q
Date: Wed, 9 May 2018 14:27:48 +0000
Message-ID: <36baff2c776a4c3799f40a9033fc90fc@AcuMS.aculab.com>
References: <20180505192112.GA18728@zrhn9910b>
In-Reply-To: <20180505192112.GA18728@zrhn9910b>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: damian
> Sent: 05 May 2018 20:21
> is something special to note when kernel build with gcc 8? I receive various warnings from the
> objtool:

Someone ought to persuade the gcc folks to try compiling the Linux kernel
before releasing a new compiler :-)

	David
