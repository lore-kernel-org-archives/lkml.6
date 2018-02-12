Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeBLS2Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:28:16 -0500
Received: from us-smtp-delivery-194.mimecast.com ([216.205.24.194]:29172 "EHLO
        us-smtp-delivery-194.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752478AbeBLS2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:28:14 -0500
From: Trond Myklebust <trondmy@primarydata.com>
To: "bfields@fieldses.org" <bfields@fieldses.org>
CC: "thiago.becker@gmail.com" <thiago.becker@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] sunrpc: Add task's xid to 'not responding' messages on
 call_timeout
Thread-Topic: [PATCH] sunrpc: Add task's xid to 'not responding' messages on
 call_timeout
Thread-Index: AQHTogt7Yp0+W1/3xkaHrbuszyHK96Oc3I8AgAQjuICAABoTgA==
Date: Mon, 12 Feb 2018 18:28:07 +0000
Message-ID: <1518460085.3725.3.camel@primarydata.com>
References: <20180210010628.19792-1-thiago.becker@gmail.com>
         <1518226912.22856.3.camel@primarydata.com>
         <20180212165445.GD3294@fieldses.org>
In-Reply-To: <20180212165445.GD3294@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.49.162.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB1755;7:NgCEQ8bTKCe4yqrijshn6V9+FO6MjREFASl+qD5Ct9PEYTz6Dhoad9Svc75J21dafWmtaM0xk5fsPXjn1TflYW1J0LTAo48stQsuCIEJRNDlir0GI9MT8oXj1QAvL3OPvSIglnctgIzv+TfuhT2EQ3ekSGS/4ebUrWkNpH5DZEDV2O/iNDD4fFUm5wmi4SMb6jY2aiLF3TXqs0l1lNb1B9Ikwpfr+SslTJutb9wcI1X4PqqK6KyvqIxAuVi6nxnS;20:f7EH2lrDkNpLplm+rEPG7UVsPupVKT0OwTWAnn54P7/YcKE6xJCQJEP70ERYFQ6Q5Pru6N5/rTDqYvSbBx/K/yXITfw0fnXmnS0RmVKSeebmWsKp9IjOt/HUIg699WThXnd2m1IIFcHUP5AcTKyhiSrSbefR+VdKqeA8GNPn02E=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 11b3713b-7a13-4b05-6d83-08d572465d41
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(3008032)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603307)(7153060)(7193020);SRVR:DM5PR11MB1755;
x-ms-traffictypediagnostic: DM5PR11MB1755:
x-microsoft-antispam-prvs: <DM5PR11MB1755F6620BE474C8DFDB2A15BEF70@DM5PR11MB1755.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231101)(944501161)(3002001)(93006095)(93001095)(6041288)(2016111802025)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:DM5PR11MB1755;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB1755;
x-forefront-prvs: 0581B5AB35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(376002)(396003)(39380400002)(366004)(189003)(199004)(377424004)(229853002)(5660300001)(6246003)(6436002)(8936002)(305945005)(81166006)(76176011)(6512007)(2900100001)(1730700003)(81156014)(3280700002)(97736004)(6916009)(14454004)(186003)(102836004)(53936002)(15650500001)(26005)(6116002)(3846002)(2950100002)(7736002)(25786009)(316002)(68736007)(2906002)(103116003)(54906003)(106356001)(5250100002)(5640700003)(4326008)(478600001)(3660700001)(66066001)(59450400001)(2501003)(8676002)(99286004)(105586002)(39060400002)(2351001)(36756003)(86362001)(6486002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR11MB1755;H:DM5PR11MB0075.namprd11.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: JWaYeagfBxwJpAwvteu10+dWooN7Bdv3Z7x+42NSa+cIQDM4RApyCQjm2emoEPUrV2JarsoGCXVd2eqR/RQg3A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <008C1C26197C07408D2C65BF8FC8D245@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: primarydata.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b3713b-7a13-4b05-6d83-08d572465d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2018 18:28:07.6107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03193ed6-8726-4bb3-a832-18ab0d28adb7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1755
X-MC-Unique: O0OVuqiEPPea-Jly51q7Zg-1
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1CISL2m016322

On Mon, 2018-02-12 at 11:54 -0500, bfields@fieldses.org wrote:
> On Sat, Feb 10, 2018 at 01:41:55AM +0000, Trond Myklebust wrote:
> > On Fri, 2018-02-09 at 23:06 -0200, Thiago Rafael Becker wrote:
> > > When investigating reasons for nfs failures, packet dumps arei
> > > eventually used.
> > > Finding the rpc that generated the failure is done by comparing
> > > all
> > > sent
> > > rpc calls and all received rpc replies for those which are
> > > unanswered,
> > > which is prone to errors like
> > > - Slow server responses
> > > - Incomplete and uncaptured packets in the packet dump
> > > - The heuristics used to inspect packets failing to interpret one
> > > 
> > > This patch adds the xid of rpc_tasks to the 'not responding'
> > > messages
> > > in call_timeout to make these analysis more precise.
> > > 
> > > Signed-off-by: Thiago Rafael Becker <thiago.becker@gmail.com>
> > > ---
> > >  net/sunrpc/clnt.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > > index e2a4184f3c5d..83c8aca951f4 100644
> > > --- a/net/sunrpc/clnt.c
> > > +++ b/net/sunrpc/clnt.c
> > > @@ -2214,9 +2214,10 @@ call_timeout(struct rpc_task *task)
> > >  	}
> > >  	if (RPC_IS_SOFT(task)) {
> > >  		if (clnt->cl_chatty) {
> > > -			printk(KERN_NOTICE "%s: server %s not
> > > responding, timed out\n",
> > > +			printk(KERN_NOTICE "%s: server %s not
> > > responding, timed out (xid: %x)\n",
> > >  				clnt->cl_program->name,
> > > -				task->tk_xprt->servername);
> > > +				task->tk_xprt->servername,
> > > +				be32_to_cpu(task->tk_rqstp-
> > > > rq_xid));
> > > 
> > >  		}
> > >  		if (task->tk_flags & RPC_TASK_TIMEOUT)
> > >  			rpc_exit(task, -ETIMEDOUT);
> > > @@ -2228,9 +2229,10 @@ call_timeout(struct rpc_task *task)
> > >  	if (!(task->tk_flags & RPC_CALL_MAJORSEEN)) {
> > >  		task->tk_flags |= RPC_CALL_MAJORSEEN;
> > >  		if (clnt->cl_chatty) {
> > > -			printk(KERN_NOTICE "%s: server %s not
> > > responding, still trying\n",
> > > +			printk(KERN_NOTICE "%s: server %s not
> > > responding, still trying (xid: %x)\n",
> > >  			clnt->cl_program->name,
> > > -			task->tk_xprt->servername);
> > > +			task->tk_xprt->servername,
> > > +			be32_to_cpu(task->tk_rqstp->rq_xid));
> > >  		}
> > >  	}
> > >  	rpc_force_rebind(clnt);
> > 
> > NACK. We should not be logging internal information such as XIDs as
> > KERN_NOTICE messages.
> 
> I didn't now that was a general rule.  Is it that KERN_NOTICE (and
> higher?) messages are expected to be leaked to users we don't trust?
> 
> I also wouldn't have expected XIDs to be terribly useful to an
> attacker.
> But maybe it could help inject a malicious reply.
> 

As I said, the information is already available to privileged users.
They can turn on dprintks, tracepoints, or they can look in
/sys/kernel/debug. The ONLY reason for putting this information into
the above notice would be to allow unprivileged users to get the same
info displaying on their tty consoles.

What are said unprivileged users going to do with this information?
What does it allow them to do that they could not do before?

-- 
Trond Myklebust
Linux NFS client maintainer, PrimaryData
trond.myklebust@primarydata.com
