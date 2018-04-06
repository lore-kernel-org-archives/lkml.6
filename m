Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeDFUA3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:00:29 -0400
Received: from mail-cys01nam02on0075.outbound.protection.outlook.com ([104.47.37.75]:23701
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751579AbeDFUA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:00:28 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vadim.Lomovtsev@cavium.com;
Date: Fri, 6 Apr 2018 13:00:23 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: linux-kernel@vger.kernel.org
Cc: vadim.lomovtsev@cavium.com
Subject: Re: [Question] patch posting process
Message-ID: <20180406200023.GA16089@localhost.localdomain>
References: <20180406182916.GA15772@localhost.localdomain>
 <20180406192146.GA384@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406192146.GA384@1wt.eu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM3PR12CA0046.namprd12.prod.outlook.com
 (2603:10b6:0:56::14) To DM5PR07MB3002.namprd07.prod.outlook.com
 (2603:10b6:3:e3::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfa2c4b5-8c1b-4955-6d49-08d59bf90a46
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3002;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;3:gPoCBzVPz3IZty6HifA9K4yjXrivil7b1nep9wGHdU68GpdWbDhGDOBc1ByMUjQqlPwZV+O/V2bBslLVROfb43mnfaaRzuC8AUkEKPQt7A5/1pmLAQIthVJxcsL0qX4wGQMSiESsGv1I1nNLos/LLqTEoRjh2d9a2TbW7UZS1s6mOHlH7MweLdpt8OWhRicROfaYA+0Ul+UF8lkJA1gzwU5XzvT/9ijtvj4QC4roQh859/b/E75Lcmgsfb101CvQ;25:+K32d/RtuPMrh6UHojWsYHJhxHbTDh0mYXRfwypcoI4ByF3k4m2TSe7hTC9doUE4pxqXG8v8fn5AaY0F42trVtCFCbR9nDMcFBi/mtFGW3189XSGgJZQ1zDadaJYKSJyDTLyX5mtL5nhts3cjhEQ0GfZKZZxZP1oKLpgbY38SCfPK7utv4iC0HRc4u20LsFW/J/RYn63X7oD1zHzfIqqRu7zXmnv3urtt1AqgOs5XgJxSKmphqHcg6CzENJzWxAUpUwpjkZRcAIvz1gAqvn0Cb5AMwhs7d+56wuDGbiM74qhaxD7BltVi3arEbCOSUV+DnMurEuRDrxJTu7odo4y6g==;31:DzwxsjZjjm0RJ9lEsDJLRsz/lrY2t69i6fjuDhfquwjorVgmfVfDeqDSp97vESoZ3lmF+9pdvO/rLfVdW7SNuMEZpS6UIRFPaTTwCx0Oxdl19Fxno/5z66bdGH0sJy2a6KzXwiLFTRW3VlRzUS9oMSjtO8ffzNj8M86SZyNqSu1TYT/iTf6kHEOLitE7O9nJG2ZOPUfla9XlMO2aF4hd29QuVvqrU8QlfrMvMysUvBo=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3002:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;20:QZcs94gLXLYAFuP7GMHw+vl4mZGk7BbljMzosu04CqKLgbnNQMxxvsM5obEDhSR96TSm4SSqCDQe0QtGx4gnNxxluOdQTMJIyZhULqM1EtQnL6ib/ukssEFjfT275L8effWPzLHK7eYjlK5FzPAr1SkjkadeyaE7RRJQK8J7DkJMPLHjZNlO2TwT8kZp+xfm8em6UaSKtzjCPk8xeHQ2A6P5XAk07i6dA3p6iOofPll6Pf1eKcNOFkS/T5q58+3sWrOjz3s5GShXklD6cOPi6vAodGDTo4cbdGjqsAH1rdcq6BfcfvnG0oLeLTxqlp5yFOHy1io7tifm+u2pBzPHhHgZCVe/aMR8ULkmey0fb6XNLw5ZZ5SAY2WbRJS6EMIKgE+cNrcuSDN2OhbuWZ7WGIiHkv7H7XJgixkyFmOPzIpIzFVdnvNh6pq6BGd5A193fRfgjri2fiPml6D5xZYJMfZhHsO6t2EvCNFX7wODQ5kIoXC0yfom4GlxtJqAcge670a1DHLQBjTbfWknaOOUUSMAsNQUpzldqz5rEWzrPH07nB5gYr3rV+BXqeXquEbNfJvWwgLl5I4pXk/4O+8KLW2+piKe/934K5Nz9ORh2aY=;4:q99hFC5gex1B3oVTkixbkmA8ZmrGis0mXyFAGpVZ1kW26HFXq7dJiQgRvjQZn3efaX4zyvCFswWSm4ihL3yC4Iy+qzWTbiqEKLvPXJ4lsxq8BAD83b1gIbfLriO4jv5JekbLJvRNXRKIewgbk7lQPPBFBoCKIY+ayGujUr0bjqWVZjn7/8lf0VNMQRdSHWSiT2jJE/bF9hkrwIYfwCk1aoGq2CvVXdrWamOm296pTnsqOf3aTVVQwYkNFN7sVLvCm9nvifYpJrL+kfDAPIB3Hw==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3002D51E18EC387777A198678ABA0@DM5PR07MB3002.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR07MB3002;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3002;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(376002)(366004)(346002)(39860400002)(396003)(53754006)(189003)(199004)(345774005)(956004)(446003)(11346002)(50466002)(26005)(16526019)(186003)(2906002)(476003)(486006)(23726003)(6116002)(3846002)(6916009)(6666003)(58126008)(9686003)(55016002)(316002)(68736007)(25786009)(229853002)(6246003)(1076002)(42882007)(53936002)(5660300001)(16586007)(33656002)(8676002)(72206003)(61506002)(305945005)(107886003)(478600001)(66066001)(6506007)(33896004)(2351001)(59450400001)(4326008)(8936002)(97736004)(386003)(106356001)(7736002)(81166006)(105586002)(2361001)(81156014)(76176011)(47776003)(7696005)(52116002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3002;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3002;23:j3I7neltDIGxKJgFg0W5etRcfwr1vxn3dlWB1w4lA?=
 =?us-ascii?Q?TqJfuV8J2hmd1qMjRfXUWHev2hKI1gMma8/ciYyaRwcd844JfBMVNByKxA7z?=
 =?us-ascii?Q?4Rc3ayRyfnnSBc2y3qhYW+maDIMdPz1kBVtQioToOmVV5ZPQYOlIF0txweIv?=
 =?us-ascii?Q?s5kSXoawA/w4C7Sq1WqNS+wfY4+RO/B+ReyPdtPpRPeZvK2T+6rvQNog5VSx?=
 =?us-ascii?Q?maKTswuhdFVd65pvu6oMHPG4DkXGMucEGLqu6P1+4o5t/1FI6rX+Ue/LDnEP?=
 =?us-ascii?Q?cF2jfysDfp+RAOWQLANydZg+SzJR7PHbFOH61fO6vMMktXAeWhazMioI8Q2C?=
 =?us-ascii?Q?/dk05ogocfCSnanv3mvMCfqcOlMzQWv3E7iiqJBaOsClG+ryLQk5A+SW9+4q?=
 =?us-ascii?Q?SXymJlW/TSRjTWmR4uZzp1uybYisCL4vvzU+gEv0Iv6W9vwo9DAkC8XO+ate?=
 =?us-ascii?Q?4tmTOV1a+eZA1rqfec51KQBtGJn//K6F/mZnbLn54RF9nlswgnq8ifNU2PZQ?=
 =?us-ascii?Q?2BEqZHfVnJvApr7X8nYotTIUGtnSFkVX+BNEMiGDWOynmjzxUH6Hkx9bUr1L?=
 =?us-ascii?Q?VnNVslAu1cPYDsqh8vLUeTqBcfFWZeXNAs07UUhqOPlWDMo8bn3ebcfbm3/H?=
 =?us-ascii?Q?hBp5q1oYLLZQb9LGhO8tHxaszm4shbzmVsp83bUha4UBsXBEb3k8c0qon6cE?=
 =?us-ascii?Q?UijgP0y85gi5/8LLtEjpC5e6RcQKlE+ied6AvPbPiKggJjCMtZgrwwYYxwS3?=
 =?us-ascii?Q?qHlnaAy/zATLT9pe1QAslwXqWrQMOAHhn8+462drPXoP2HW+XTSg1iRU6dB+?=
 =?us-ascii?Q?xZ6UFd8PQvlVwAjCWz5X0S28iygCHraKGwCsXteh3LHGwSbQttmOB9MlNJxW?=
 =?us-ascii?Q?qFHoPlDx8R053+rg2LlI4a2jrb4nFWhf1i7VZqrJD7occVxO8w1ujQ93mOaV?=
 =?us-ascii?Q?cbsBtzb/WNT9gNkuxmo1fzndAx7TdXcQVlJurC3m83jbWbI6YqIb8/5xyX8J?=
 =?us-ascii?Q?EuIg4ld6V4/Z4D4EfylnVLg15uWVBoDLIMyNS8C2ixmUxu7Ib4Y0pVRepTkD?=
 =?us-ascii?Q?Qq5HbDfxa8UrLRWTv9deSglmbXsz0GxMmsNUuYoAdu42vf9SoyCusxnYoTpF?=
 =?us-ascii?Q?9AwdVutpC1JXV8GZlnsTM9KGcLjQg5jdbOpCXd0OhMCgmPb1HcDG8m2yR7gZ?=
 =?us-ascii?Q?zZC+KhYfmt05C1nXmWa4EO61C5jXZ0Os6Itl0TYjZw6OAeEPd8+6rxKo227x?=
 =?us-ascii?Q?AhrE37uGWpYZ/eClGgxv7UC/gJFd2HYttKBD9WTnGB7/UFoKNF7PC4jiTIHW?=
 =?us-ascii?Q?eF2rYUp49Yqp1JwXacqGIyDFrfpwKlpePilCjuHwSGnBSfqTkvqCqtynK0Nd?=
 =?us-ascii?Q?u/UHN6ehfFC2Tat6oGlRLA1Q2Eh35PEBGmdgvosGzSDsmFWgCwpgKcvPPkEh?=
 =?us-ascii?Q?M6jgJKfTBISssEAfegUQZcjc1VWHrEe9IBvw5zitD+Yz+KprWVc?=
X-Microsoft-Antispam-Message-Info: T63BSzR6bYWSqWc9QwmkoBt1jJZuWJLMaJEHeSLWKyY1MuItFj16uX3auy+dHDRrVDtwRkzzdVaSQi8zEuJQkFpcPDvSzcCnP4i68/wZiWgdVeT0D5jbzqn/MA/eiEum7tT4kQKRQExuTiTXsFAPzID4p6MOqD0ZqOaqugKDvkFX6fnQRGiDljOhLUTCswj7
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;6:gg/MDQuXcdS/OfZQHmYU1SRMQD76ZyggclIHb/pWGQKKorU7oxcBgTJqqkC1U2yWmQSXiQ7srGfkOHdrzXtW/PBEyVrb22Gu1RTS2rR/uwD0LvXfY25h9TuIRzlullgYu7N6QLxRkz3bppY2z2LqGhtjaymN0O2NlbgA7scKBK/z2GneGymErPV2IxMHixUpBOiZsqkmQ+t2jTJDvomTpvPxKTwIw7yEkzpxtPBUAItNLcKZA3HmFogED7A+ptw5fx5W+ixDacvazhXbYrcI1GgaWD7A6SoJsOpm1YDrxQpZotVbca1ElPnoJIVFOW/KPQrectG/8QV4cMciM+Sn+jwW3N/rkFOui9pQgGN6Mi/qMLKnSnO/XBL0AflsU+gkwRpW1MZrk9YwGF57isJ97FJomUbbg47/mnMnv8lbACi+/mVc79W7MFzemKkuYgDzFr4AjAbzQhYI4ToTzLy3Gw==;5:lItRf83tVtbO+H/UHZb4A4edF3W57I+rGsA8ZWEGyovNtUVWLtL+Y7z1r1jo5HOGdcg7K4pMd2zDUqiOuJECGGO/Wth1iFFWSU0eGBKFkOF9PtHK0Z7CGz9MbOAuSxlQTbHfRGKT2MZJ1I4VAEUvFZqSd2zDQpioTGtzPOUBM8o=;24:EBw4SM13+fVOqUAQ/ljN/SJzh7mvGDHto8znJKCPj2KJByOqYLe2JRE3ssTmIHsdtPDovFo8jMEpCuP0o0AzF5AdVLBcQFPEbK7hVL79fm8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3002;7:IxKD2sz0Bv91+405IhnKHmkdlwmk/UXQB1XTz8LSOOSGDNFQm/ymZ7qOETZb/uuyiw4amskfAn6Yr2PSpGeY50ivQqZqULoh/xIhJjj3SAXpnEKCOxA7gaKTRxaRg4KN7gv/B3ku3HW0YIrFgNs+Jnqgug/oA5uNkwTS46rqN1K5xXfc7W/NzusuM0kiUzubBFBi/DXWICSMiQkIlVeELPUit+qkwJevXmlbHhEYu5ioOrwyvpfjSYUb+kqr+zZf
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 20:00:26.1999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa2c4b5-8c1b-4955-6d49-08d59bf90a46
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3002
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

Thank you for your opinion, it's very helpful.

WBR,
Vadim

On Fri, Apr 06, 2018 at 09:21:46PM +0200, Willy Tarreau wrote:
> Hi Vadim,
> 
> On Fri, Apr 06, 2018 at 11:29:16AM -0700, Vadim Lomovtsev wrote:
> > Hi all,
> > 
> > I bring my Apologise for wasting your time, but ..
> 
> Questions about doing things right rarely are a waste of time if they save
> others from having to do useless work!
> 
> > May I ask for some clarification.. When we're speaking of 'posting patches shortly'
> > does it mean to send them in next few hours ?
> > Or would it be more acceptable to post one version per day
> > even for very small changes in between ?
> > 
> > Kernel posting guides says that one should wait for about a week for respond,
> > but in my case I've got feedback rather quickly (thanks a lot for that!)
> > and I'd assume that I can proceed with posting next version.
> > 
> > So, what is the proper approach here - should one wait day or two
> > before posting next version even if changes are very simple ?
> 
> Generally speaking, it's better to proceed ASAP. Reviewing patches requires
> some concentration and often some time to get into the context. Speaking for
> myself only, when I'm reviewing patches (I reserve time to do it), I prefer
> to get 3 round trips the same day than one per week and each time having to
> try to recall what it was about and what I proposed.
> 
> Also some people may only do that on spare time, week-ends or dedicated day
> in the week. If you sit on their e-mail for no reason, you expose yourself
> to the risk of having to wait for the next feedback. This is where the week
> comes from. Another nice side effect of the week delay is that some people
> send a first version for reviewing and figure by themselves that this
> version is bogus, then send a fixed version. That reduces the number of
> required work for reviewers.
> 
> On the other hand, it's not nice to rush quick updates without verifying
> that you properly addressed all reported points (addressed either in code
> or discussion). Thus my recommendation would be that if you can iterate
> one or two extra rounds the same day, that's generally much better. And
> in any case if the reviewer doesn't have more time to assign to you, he
> will switch to something else and you'll have to wait. Thus the good rule
> could be that ideally reviewers should not needlessly be waiting for you.
> 
> One important point however is *not* to send multiple versions of the
> same series without waiting for a review. Someone might already be reading
> your patchset and be pissed off by discovering he's reading outdated
> code. Reserve this for the cases where you've let a huge bug slip
> through.
> 
> Just my two cents, others will very likely have other advices.
> 
> Willy
